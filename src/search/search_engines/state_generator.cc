#include "state_generator.h"

#include "../evaluation_context.h"
#include "../evaluator.h"
#include "../open_list_factory.h"
#include "../option_parser.h"
#include "../pruning_method.h"

#include "../algorithms/ordered_set.h"
#include "../task_utils/successor_generator.h"
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

StateGenerator::StateGenerator(const Options &opts)
    : SearchEngine(opts),
      open_list(opts.get<shared_ptr<OpenListFactory>>("open")->create_state_open_list()),
      h_evaluator(opts.get<shared_ptr<Evaluator>>("eval")),
      match_tree(task_proxy),
      best_state(task->get_num_variables(), -1) {
}

void StateGenerator::initialize() {
    cout << "Conducting best first search"
         << " (real) bound = " << bound
         << endl;
    assert(open_list);

    set<Evaluator *> evals;
    open_list->get_path_dependent_evaluators(evals);
    path_dependent_evaluators.assign(evals.begin(), evals.end());

    /*
      Set initial state
    */
    GoalsProxy goal_facts = task_proxy.get_goals();
    for (uint i = 0; i < goal_facts.size(); i++) {
        FactPair fact = goal_facts[i].get_pair();
        best_state[fact.var] = fact.value;
    }
    const GlobalState& goal_state = state_registry.get_state(best_state);

    for (Evaluator *evaluator : path_dependent_evaluators)
        evaluator->notify_initial_state(goal_state);

    /*
      Note: we consider the initial state as reached by a preferred
      operator.
    */
    EvaluationContext eval_context(goal_state, 0, true, &statistics);

    statistics.inc_evaluated_states();

    if (search_progress.check_progress(eval_context))
        statistics.print_checkpoint_line(0);
    SearchNode node = search_space.get_node(goal_state);
    node.open_initial();

    open_list->insert(eval_context, goal_state.get_id());

    print_initial_evaluator_values(eval_context);
    
    // Build reverse operators
    VariablesProxy variables = task_proxy.get_variables();
    for (OperatorProxy op : task_proxy.get_operators())
        reverse_search::build_reverse_operators(op, op.get_cost(), variables, operators);
    
    // Match Tree
    for (size_t op_id = 0; op_id < operators.size(); ++op_id)
        match_tree.insert(op_id, operators[op_id].regression_preconditions);
    
}

SearchStatus StateGenerator::step() {
    tl::optional<SearchNode> node;
    tl::optional<GlobalState> node_state;
    vector<int> state_values;
    while (true) {

        if (open_list->empty()) {
            cout << "Completely explored state space." << endl;
            return SOLVED;
        }

        StateID id = open_list->remove_min();
        // TODO is there a way we can avoid creating the state here and then
        //      recreate it outside of this function with node.get_state()?
        //      One way would be to store GlobalState objects inside SearchNodes
        //      instead of StateIDs
        node_state.emplace(state_registry.lookup_state(id));
        node.emplace(search_space.get_node(*node_state));

        if (node->is_closed())
            continue;

        EvaluationContext eval_context(*node_state, node->get_g(), false, &statistics);

        state_values = node_state->unpack().get_values();

        // Update best state
        int node_h = eval_context.get_evaluator_value_or_infinity(h_evaluator.get());
        if (node_h > best_state_h) {
            best_state = state_values;
            best_state_h = node_h;
            if (node_h > bound) {
                cout << "Reached h bound." << endl;
                return SOLVED;
            }
        }

        node->close();
        assert(!node->is_dead_end());
        statistics.inc_expanded();
        break;
    }

    set<int> applicable_operator_ids;
    match_tree.get_applicable_operator_ids(state_values, applicable_operator_ids);

    cout << "APPLICABLE OPERATOR IDS: " << applicable_operator_ids.size() << endl;

    for (int op_id : applicable_operator_ids) {
        ReverseOperator& op = operators[op_id];

        vector<int> pred_values(state_values);
        op.apply(pred_values);

        GlobalState pred_state = state_registry.get_state(pred_values);
        statistics.inc_generated();

        SearchNode pred_node = search_space.get_node(pred_state);

        /*for (Evaluator *evaluator : path_dependent_evaluators) {
            evaluator->notify_state_transition(pred_state, op_id, *node_state);
        }*/

        if (pred_node.is_new()) {
            int pred_g = node->get_g() + 1;

            EvaluationContext pred_eval_context(
                pred_state, pred_g, false, &statistics);
            statistics.inc_evaluated_states();

            //pred_node.open(*node, op, 1);

            open_list->insert(pred_eval_context, pred_state.get_id());
            if (search_progress.check_progress(pred_eval_context)) {
                statistics.print_checkpoint_line(pred_node.get_g());
                reward_progress();
            }
        }
    }

    return IN_PROGRESS;
}

void StateGenerator::print_statistics() const {
    statistics.print_detailed_statistics();
    search_space.print_statistics();
}

void StateGenerator::reward_progress() {
    // Boost the "preferred operator" open lists somewhat whenever
    // one of the heuristics finds a state with a new best h value.
    open_list->boost_preferred();
}

void StateGenerator::dump_search_space() const {
    search_space.dump(task_proxy);
}

void StateGenerator::save_plan_if_necessary() {
    // No plan to save.
}

void StateGenerator::save_task_if_necessary() {
    for (uint i = 0; i < best_state.size(); i++) {
        if (best_state[i] == -1)
            best_state[i] = 0;
    }
    shared_ptr<AbstractTask> new_task = make_shared<extra_tasks::ModifiedInitTask>(task, best_state);
    ofstream file("new_output.sas");
    file << new_task;
    file.close();
}

bool StateGenerator::found_solution() const {
    return true;
}

void add_options_to_parser(OptionParser &parser) {
    parser.add_option<shared_ptr<Evaluator>>("eval", "evaluator for h-value");
    SearchEngine::add_options_to_parser(parser);
}

}
