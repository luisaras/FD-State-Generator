#include "generator_all_goals.h"

#include "../evaluation_context.h"
#include "../evaluator.h"
#include "../option_parser.h"
#include "../pruning_method.h"

#include "../algorithms/ordered_set.h"
#include "../task_utils/task_properties.h"

#include "../utils/logging.h"

#include <cassert>
#include <cstdlib>
#include <fstream>
#include <memory>
#include <optional.hh>
#include <set>

using namespace std;
using namespace reverse_search;

namespace state_generator {

GeneratorAllGoals::GeneratorAllGoals(const Options &opts)
    : StateGenerator(opts) {
}

void GeneratorAllGoals::insert_goals_recursive(uint var) {
    if (var == best_state.size()) {
        // All variables defined
        const GlobalState& goal_state = state_registry.get_state(best_state);
        EvaluationContext goal_state_eval(goal_state, 0, false, &statistics);
        search_space.get_node(goal_state).open_initial();
        open_list->insert(goal_state_eval, goal_state.get_id());
        goal_count++;
    } else {
        if (best_state[var] != -1) {
            // Current variable already defined by goal facts
            insert_goals_recursive(var + 1);
        } else {
            // Insert new states for each possible variable value
            int domain_size = task->get_variable_domain_size(var);
            for (int value = 0; value < domain_size; ++value) {
                best_state[var] = value;
                insert_goals_recursive(var + 1);
            }
            best_state[var] = -1;
        }
    }
}

void GeneratorAllGoals::initialize() {
    StateGenerator::initialize();
    
    // All variables have "undefined" values
    for (uint i = 0; i < best_state.size(); ++i)
        best_state[i] = -1;
    
    // Create goal state
    GoalsProxy goal_facts = task_proxy.get_goals();
    for (uint i = 0; i < goal_facts.size(); ++i) {
        FactPair fact = goal_facts[i].get_pair();
        best_state[fact.var] = fact.value;
        cout << fact << " ";
    }
    cout << endl;

    cout << "Inserting initial (goal) states..." << endl;
    
    // Insert goal state
    insert_goals_recursive(0);
    
    cout << "Inserted " << goal_count << " goals." << endl;
    
}

SearchStatus GeneratorAllGoals::step() {
    // Select next node
    vector<int> state_values;
    tl::optional<SearchNode> node;
    while (true) {
        if (open_list->empty()) {
            cout << "Completely explored state space." << endl;
            return SOLVED;
        }
        StateID id = open_list->remove_min();
        GlobalState node_state = state_registry.lookup_state(id);
        node.emplace(search_space.get_node(node_state));
        state_values = node_state.unpack().get_values();
        if (node->is_closed())
            continue;
        node->close();
        assert(!node->is_dead_end());
        statistics.inc_expanded();
        break;
    }
    
    // Gets operators
    set<int> applicable_operator_ids;
    match_tree.get_applicable_operator_ids(state_values, applicable_operator_ids);
    
    //cout << "APPLICABLE OPERATORS: " << applicable_operator_ids.size() << endl;

    // Expand
    for (int op_id : applicable_operator_ids) {
        
        // Get values of previous state
        ReverseOperator& op = operators[op_id];
        vector<int> pred_values(state_values);
        op.apply(pred_values);
        
        // Get search node of previous state
        GlobalState pred_state = state_registry.get_state(pred_values);
        statistics.inc_generated();
        SearchNode pred_node = search_space.get_node(pred_state);
        
        if (pred_node.is_new()) {
            
            pred_node.open(*node, task_proxy.get_operators()[op.original_id], op.cost);
            
            EvaluationContext eval_context(pred_state, pred_node.get_g(), false, &statistics);

            // Update best state
            int h = eval_context.get_evaluator_value_or_infinity(h_evaluator.get());
            assert(h < 2147483647);
            
            if (h > best_state_h) {
                best_state = pred_values;
                best_state_h = h;
                cout << "New best h: " << best_state_h << " (iteration " << it_count << ")" << endl;
                if (h > bound) {
                    cout << "Reached h bound." << endl;
                    return SOLVED;
                }
            }

            // Check iteration limit
            it_count++;
            if (max_it >= 0 && it_count >= max_it) {
                cout << "Reached iteration limit." << endl;
                return SOLVED;
            }

            // Insert node in list
            open_list->insert(eval_context, pred_state.get_id());
            if (search_progress.check_progress(eval_context)) {
                statistics.print_checkpoint_line(pred_node.get_g());
                reward_progress();
            }
            
        }
        
    }

    return IN_PROGRESS;
}

}
