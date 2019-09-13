#include "generator_random_goal.h"

#include "../evaluation_context.h"
#include "../evaluator.h"
#include "../option_parser.h"
#include "../pruning_method.h"

#include "../utils/logging.h"
#include "../utils/rng.h"

#include <cassert>
#include <cstdlib>
#include <fstream>
#include <memory>
#include <optional.hh>
#include <set>

using namespace std;
using namespace reverse_search;

namespace state_generator {

utils::RandomNumberGenerator random(0);

GeneratorRandomGoal::GeneratorRandomGoal(const Options &opts)
    : StateGenerator(opts),
      current_best_state(task->get_num_variables()),
      convergence_max(opts.get<int>("convergence")) {
}

void GeneratorRandomGoal::initialize() {
    StateGenerator::initialize();
    next_goal_state();
}

SearchStatus GeneratorRandomGoal::step() {
    // Select next node
    vector<int> state_values;
    tl::optional<SearchNode> node;
    while (true) {
        if (open_list->empty()) {
            //cout << "Creating new goal state..." << endl;
            if (!next_goal_state()) {
                cout << "Completely explored state space." << endl;
                return SOLVED;
            }
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
            
            assert(node.has_value());
            pred_node.open(*node, task_proxy.get_operators()[op.original_id], op.cost);
            
            EvaluationContext eval_context(pred_state, pred_node.get_g(), false, &statistics);
            // Update best state
            int h = eval_context.get_evaluator_value_or_infinity(h_evaluator.get());
            if (h > current_best_state_h) {
                current_best_state = pred_values;
                current_best_state_h = h;
                convergence_count = 0;
                if (h > best_state_h) {
                    best_state = pred_values;
                    best_state_h = h;
                    cout << "New best h: " << best_state_h << " (iteration " << it_count << ")" << endl;
                    if (h > bound) {
                        cout << "Reached h bound." << endl;
                        return SOLVED;
                    }
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

    convergence_count++;
    if (convergence_count > convergence_max) { // ass-pulled limit
        cout << "Converged to " << current_best_state_h << ". " << endl;
        open_list->clear();
    }

    return IN_PROGRESS;
}

bool GeneratorRandomGoal::next_goal_state() {
    VariablesProxy variables = task_proxy.get_variables();

    do {
        // Random state
        for (uint i = 0; i < current_best_state.size(); ++i) {
            int domain_size = variables[i].get_domain_size();
            current_best_state[i] = random(domain_size);
        }
        // Transform to goal state
        GoalsProxy goal_facts = task_proxy.get_goals();
        for (uint i = 0; i < goal_facts.size(); ++i) {
            FactPair fact = goal_facts[i].get_pair();
            current_best_state[fact.var] = fact.value;
        }
        const GlobalState& goal_state = state_registry.get_state(current_best_state);

        SearchNode node = search_space.get_node(goal_state);

        if (node.is_new()) {

            for (Evaluator *evaluator : path_dependent_evaluators)
                evaluator->notify_initial_state(goal_state);

            EvaluationContext eval_context(goal_state, 0, true, &statistics);

            statistics.inc_evaluated_states();
            if (search_progress.check_progress(eval_context))
                statistics.print_checkpoint_line(0);

            node.open_initial();
            node.get_g();
            open_list->insert(eval_context, goal_state.get_id());
    
            convergence_count = 0;
            current_best_state_h = 0;
            if (best_state_h == -1) {
                best_state_h = 0;
                best_state = current_best_state;
            }

            break;
        }

    } while (true);

    //cout << "Inserted goal state." << endl;
    return true;
}

void GeneratorRandomGoal::add_options_to_parser(OptionParser &parser) {
    parser.add_option<int>("convergence", "Convergence threshold", "1000");
}

}