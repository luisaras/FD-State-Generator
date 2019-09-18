#include "generator_abstract_goal.h"

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

GeneratorAbstractGoal::GeneratorAbstractGoal(const Options &opts)
    : StateGenerator(opts) {
}

void GeneratorAbstractGoal::initialize() {
    StateGenerator::initialize();
    
    // task->get_undef_value();
    
    // All variables have "undefined" values
    for (uint i = 0; i < best_state.size(); ++i)
        best_state[i] = task->get_variable_domain_size(i);
    
    // Create goal state
    GoalsProxy goal_facts = task_proxy.get_goals();
    for (uint i = 0; i < goal_facts.size(); ++i) {
        FactPair fact = goal_facts[i].get_pair();
        best_state[fact.var] = fact.value;
        cout << fact << " ";
    }
    cout << endl;

    undef_variable_count = task->get_num_variables() - goal_facts.size();
    
    cout << "Inserting initial (goal) state..." << endl;
    
    // Insert goal state
    const GlobalState& goal_state = state_registry.get_state(best_state);
    EvaluationContext goal_state_eval(goal_state, 0, false, &statistics);
    search_space.get_node(goal_state).open_initial();
    open_list->insert(goal_state_eval, goal_state.get_id());
    
}

SearchStatus GeneratorAbstractGoal::step() {
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
            
            {
                uint undefs = 0;
                int last_undef_var;
                for (uint i = 0; i < pred_values.size(); i++) {
                    if (pred_values[i] >= task->get_variable_domain_size(i)) {
                        undefs++;
                        last_undef_var = i;
                    }
                }
                if (undefs < undef_variable_count) {
                    cout << "New undef count: " << undefs << endl;
                    undef_variable_count = undefs;
                    if (undefs == 1)
                        cout << "Last undef var: " << last_undef_var << endl;
                }
            }

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
