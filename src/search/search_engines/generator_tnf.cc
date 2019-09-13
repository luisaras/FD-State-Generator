#include "generator_tnf.h"

#include "../evaluation_context.h"
#include "../evaluator.h"
#include "../open_list_factory.h"
#include "../option_parser.h"
#include "../pruning_method.h"

#include "../algorithms/ordered_set.h"
#include "../task_utils/task_properties.h"
#include "../tasks/modified_init_task.h"

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

GeneratorTNF::GeneratorTNF(const Options &opts)
    : StateGenerator(opts) {
    if (!task_properties::verify_tnf(task_proxy)) {
        cerr << "State generator needs a task in TNF."
             << endl;
        utils::exit_with(utils::ExitCode::SEARCH_UNSUPPORTED);
    }
}

void GeneratorTNF::initialize() {
    StateGenerator::initialize();
    
    /*
      Set goal state
    */
    GoalsProxy goal_facts = task_proxy.get_goals();
    for (uint i = 0; i < goal_facts.size(); i++) {
        FactPair fact = goal_facts[i].get_pair();
        best_state[fact.var] = fact.value;
    }
    const GlobalState& goal_state = state_registry.get_state(best_state);

    for (Evaluator *evaluator : path_dependent_evaluators)
        evaluator->notify_initial_state(goal_state);

    EvaluationContext eval_context(goal_state, 0, true, &statistics);

    statistics.inc_evaluated_states();
    if (search_progress.check_progress(eval_context))
        statistics.print_checkpoint_line(0);
    SearchNode node = search_space.get_node(goal_state);
    node.open_initial();

    open_list->insert(eval_context, goal_state.get_id());

    //print_initial_evaluator_values(eval_context);
}

SearchStatus GeneratorTNF::step() {
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