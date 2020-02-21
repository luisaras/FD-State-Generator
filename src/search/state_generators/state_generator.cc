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
      print_h(opts.get<int>("print_h")),
      open_list(opts.get<shared_ptr<OpenListFactory>>("open")->create_state_open_list()),
      evaluators(opts.get_list<shared_ptr<Evaluator>>("evals")),
      match_tree(task_proxy),
      best_state(task->get_num_variables()),
      best_state_eval(evaluators.size(), -1) {
    srand(0);
}

void StateGenerator::initialize() {
    if (verbosity > utils::Verbosity::SILENT)
        cout << "Conducting best first search"
             << " (real) bound = " << bound
             << endl;
    assert(open_list);

    set<Evaluator *> evals;
    open_list->get_path_dependent_evaluators(evals);
    path_dependent_evaluators.assign(evals.begin(), evals.end());

    const GlobalState& original_state = state_registry.get_initial_state();
    EvaluationContext original_state_eval_context(original_state, EvaluationResult::INFTY, false, nullptr);
    original_state_eval = evaluator_values(original_state_eval_context);
    
    if (verbosity > utils::Verbosity::SILENT)
        cout << "Building reverse operators..." << endl;
    
    // Build reverse operators
    VariablesProxy variables = task_proxy.get_variables();
    for (const OperatorProxy &op : task_proxy.get_operators()) {
        reverse_search::build_reverse_operators(op, variables, operators);
    }
    if (verbosity > utils::Verbosity::SILENT)
        cout << "Created " << operators.size() << " reverse operators." << endl;

    // Match Tree
    for (size_t op_id = 0; op_id < operators.size(); ++op_id) {
        match_tree.insert(op_id, operators[op_id].regression_preconditions);
        if (verbosity >= utils::Verbosity::VERBOSE)
            operators[op_id].dump();
    }
    if (verbosity > utils::Verbosity::SILENT)
        cout << "Built match tree." << endl;
    
}

bool StateGenerator::update_best_state(EvaluationContext& eval_context, const vector<int>& state) {
    vector<int> eval = evaluator_values(eval_context);
    vector<int> eval2 = eval;
    for (int i = 0; i < print_h; i++) {
        eval2[i] = best_state_eval[i];
    }
    if (eval2 > best_state_eval) {
        if (verbosity > utils::Verbosity::SILENT) {
            cout << "New best h: " << eval << " (iteration " << it_count << ") ";
            //dump_state(state);
            cout << endl;
        }
        best_state = state;
        best_state_eval = eval;
    }
    return false;
}

vector<int> StateGenerator::evaluator_values(EvaluationContext& eval_context) {
    vector<int> values(evaluators.size());
    for (uint i = 0; i < values.size(); i++) {
        values[i] = eval_context.get_evaluator_value_or_infinity(evaluators[i].get());
    }
    return values;
}

bool StateGenerator::pop_node(tl::optional<SearchNode>& node, vector<int>& state_values) {
    while (true) {
        if (open_list->empty()) {
            if (!on_list_empty()) {
                if (verbosity > utils::Verbosity::SILENT)
                    cout << "Completely explored state space." << endl;
                return false;
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
    return true;
}

void StateGenerator::print_statistics() const {
    statistics.print_detailed_statistics();
    search_space.print_statistics();
}

void StateGenerator::dump_state(const vector<int>& state) {
    for (uint var = 0; var < state.size(); var++) {
        if (state[var] < task->get_variable_domain_size(var)) {
            cout << var << "=" << state[var] << " ";
        }
    }
}

void StateGenerator::dump_search_space() const {
    search_space.dump(task_proxy);
}

void StateGenerator::save_plan_if_necessary() {
    // No plan to save.
}

void StateGenerator::save_task_if_necessary() {
    if (verbosity > utils::Verbosity::SILENT) {
        assert(print_h < (int) original_state_eval.size());
        cout << "Original state h-value: " << original_state_eval[print_h] << endl;
        cout << "New state h-value: " << best_state_eval[print_h] << endl;
    }
    for (uint i = 0; i < best_state.size(); i++) {
        if (best_state[i] == -1 || best_state[i] >= task->get_variable_domain_size(i))
            best_state[i] = 0;
    }
    open_list.reset();
    shared_ptr<AbstractTask> new_task = make_shared<extra_tasks::ModifiedInitTask>(task, best_state);
    ofstream file(get_plan_manager().plan_filename);
    if (file) {
        file << new_task;
        file.close();
        cout << "New task written to: " << get_plan_manager().plan_filename << endl;
    } else {
        cout << "Failed to open file: " << get_plan_manager().plan_filename << endl;
    }
}

bool StateGenerator::found_solution() const {
    return true;
}

void StateGenerator::add_options_to_parser(OptionParser &parser) {
    parser.add_list_option<shared_ptr<Evaluator>>("evals", "evaluators", "[]");
    parser.add_option<int>("max_it", "maximum number of open-list insertions", "-1");
    parser.add_option<int>("print_h", "evaluator to be printed", "0");
    SearchEngine::add_options_to_parser(parser);
}

}
