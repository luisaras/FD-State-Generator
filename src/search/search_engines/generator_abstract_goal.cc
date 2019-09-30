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
#include <set>

using namespace std;
using namespace reverse_search;

namespace state_generator {

GeneratorAbstractGoal::GeneratorAbstractGoal(const Options &opts)
    : StateGenerator(opts) {
    if (!(task_proxy.has_undef_value() || task_properties::verify_tnf(task_proxy))) {
        cerr << "State generator needs a task in TNF or undef values for all variables."
             << endl;
        utils::exit_with(utils::ExitCode::SEARCH_UNSUPPORTED);
    }
}

void GeneratorAbstractGoal::initialize() {
    StateGenerator::initialize();
    
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
    
    cout << "Inserting initial (goal) state..." << endl;
    
    // Insert goal state
    const GlobalState& goal_state = state_registry.get_state(best_state);
    EvaluationContext goal_state_eval(goal_state, 0, false, &statistics);
    search_space.get_node(goal_state).open_initial();
    open_list->insert(goal_state_eval, goal_state.get_id());

}

int best_state_g = 0;

SearchStatus GeneratorAbstractGoal::step() {
    try {

    // Select next node
    vector<int> state_values;
    tl::optional<SearchNode> node;
    if (!pop_node(node, state_values))
        return SOLVED;
    
    // Gets operators
    set<int> applicable_operator_ids;
    match_tree.get_applicable_operator_ids(state_values, applicable_operator_ids);

    /*VariablesProxy variables = task_proxy.get_variables();
    for (int op_id = 0; op_id < operators.size(); op_id++) {
        if (applicable_operator_ids.count(op_id)) {
            assert(operators[op_id].is_applicable(variables, state_values));
        } else {
            assert(!operators[op_id].is_applicable(variables, state_values));
        }
    }*/

    // Expand
    for (int op_id : applicable_operator_ids) {
        
        // Get values of previous state
        ReverseOperator& op = operators[op_id];
        vector<int> pred_values(state_values);
        op.apply(pred_values);
        
        /*if (!op.is_result(pred_values, state_values)) {
            dump_state(pred_values);
            op.dump();
            dump_state(state_values);
            assert(false);
        }*/

        // Get search node of previous state
        GlobalState pred_state = state_registry.get_state(pred_values);
        statistics.inc_generated();
        SearchNode pred_node = search_space.get_node(pred_state);

        if (pred_node.is_new()) {
            
            pred_node.open(*node, task_proxy.get_operators()[op.original_id], op.cost);
            
            EvaluationContext eval_context(pred_state, pred_node.get_g(), false, &statistics);

            // Update best state
            int h = eval_context.get_evaluator_value_or_infinity(h_evaluator.get());
            if (h == 2147483647) {
                dump_state(pred_values);
                assert(h < 2147483647);
            }
            
            if (h > best_state_h || (h == best_state_h && pred_node.get_g() > best_state_g)) {
                best_state = pred_values;
                best_state_h = h;
		best_state_g = pred_node.get_g();
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
            
        }
        
    }

    } catch (const std::bad_alloc& e) {
        open_list->clear();
        return SOLVED;
    }

    return IN_PROGRESS;
}

}
