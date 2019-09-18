#include "state_generator.h"

#include "../evaluation_context.h"
#include "../evaluator.h"
#include "../open_list_factory.h"
#include "../option_parser.h"
#include "../pruning_method.h"

#include "../tasks/modified_init_task.h"

#include "../utils/logging.h"

#include <cassert>
#include <cstdlib>
#include <fstream>
#include <memory>

using namespace std;
using namespace reverse_search;

namespace state_generator {

StateGenerator::StateGenerator(const Options &opts)
    : SearchEngine(opts),
      max_it(opts.get<int>("max_it")),
      open_list(opts.get<shared_ptr<OpenListFactory>>("open")->create_state_open_list()),
      h_evaluator(opts.get<shared_ptr<Evaluator>>("eval")),
      match_tree(task_proxy),
      best_state(task->get_num_variables()),
      best_state_h(-1) {
}

void StateGenerator::initialize() {
    cout << "Conducting best first search"
         << " (real) bound = " << bound
         << endl;
    assert(open_list);

    set<Evaluator *> evals;
    open_list->get_path_dependent_evaluators(evals);
    path_dependent_evaluators.assign(evals.begin(), evals.end());

    const GlobalState& original_state = state_registry.get_initial_state();
    EvaluationContext original_state_eval(original_state, 0, false, nullptr);
    original_state_h = original_state_eval.get_evaluator_value_or_infinity(h_evaluator.get());
    
    cout << "Building match tree..." << endl;
    
    // Build reverse operators
    VariablesProxy variables = task_proxy.get_variables();
    for (const OperatorProxy &op : task_proxy.get_operators())
        reverse_search::build_reverse_operators(op, variables, operators);

    // Match Tree
    for (size_t op_id = 0; op_id < operators.size(); ++op_id) {
        match_tree.insert(op_id, operators[op_id].regression_preconditions);

        for (const FactPair& effect : operators[op_id].regression_effects)
            cout << effect << " ";
        cout << " | ";
        for (const FactPair& effect : operators[op_id].regression_preconditions)
            cout << effect << " ";
        cout << endl;
    }
    
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
    cout << "Original state h-value: " << original_state_h << endl;
    cout << "New state h-value: " << best_state_h << endl;
    for (uint i = 0; i < best_state.size(); i++) {
        if (best_state[i] == -1 or best_state[i] >= task->get_variable_domain_size(i))
            best_state[i] = 0;
    }
    shared_ptr<AbstractTask> new_task = make_shared<extra_tasks::ModifiedInitTask>(task, best_state);
    ofstream file(get_plan_manager().plan_filename);
    file << new_task;
    file.close();
}

bool StateGenerator::found_solution() const {
    return true;
}

void StateGenerator::add_options_to_parser(OptionParser &parser) {
    parser.add_option<shared_ptr<Evaluator>>("eval", "evaluator for h-value");
    parser.add_option<int>("max_it", "maximum number of open-list insertions", "-1");
    SearchEngine::add_options_to_parser(parser);
}

}
