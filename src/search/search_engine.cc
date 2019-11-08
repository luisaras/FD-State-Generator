#include "search_engine.h"

#include "evaluation_context.h"
#include "evaluator.h"
#include "plugin.h"

#include "algorithms/ordered_set.h"
#include "task_utils/successor_generator.h"
#include "task_utils/task_properties.h"
#include "tasks/root_task.h"
#include "utils/countdown_timer.h"
#include "utils/logging.h"
#include "utils/rng_options.h"
#include "utils/system.h"
#include "utils/timer.h"

#include <cassert>
#include <iostream>
#include <limits>

using namespace std;
using utils::ExitCode;

class PruningMethod;

successor_generator::SuccessorGenerator &get_successor_generator(const TaskProxy &task_proxy, const utils::Verbosity verbosity) {
    if (verbosity > utils::Verbosity::SILENT)
        cout << "Building successor generator..." << flush;
    int peak_memory_before = utils::get_peak_memory_in_kb();
    utils::Timer successor_generator_timer;
    successor_generator::SuccessorGenerator &successor_generator =
        successor_generator::g_successor_generators[task_proxy];
    successor_generator_timer.stop();
    
    if (verbosity > utils::Verbosity::SILENT)
        cout << "done! [t=" << utils::g_timer << "]" << endl;
    int peak_memory_after = utils::get_peak_memory_in_kb();
    int memory_diff = peak_memory_after - peak_memory_before;
    if (verbosity > utils::Verbosity::SILENT)        
        cout << "peak memory difference for successor generator creation: "
             << memory_diff << " KB" << endl
             << "time for successor generation creation: "
             << successor_generator_timer << endl;
    return successor_generator;
}

SearchEngine::SearchEngine(const Options &opts)
    : opts(opts),
      status(IN_PROGRESS),
      solution_found(false),
      verbosity(static_cast<utils::Verbosity>(opts.get_enum("verbosity"))),
      task(tasks::g_root_task),
      task_proxy(*task, opts.get<bool>("undef_value")),
      state_registry(task_proxy),
      successor_generator(get_successor_generator(task_proxy, verbosity)),
      search_space(state_registry),
      search_progress(static_cast<utils::Verbosity>(opts.get_enum("verbosity"))),
      statistics(static_cast<utils::Verbosity>(opts.get_enum("verbosity"))),
      cost_type(static_cast<OperatorCost>(opts.get_enum("cost_type"))),
      is_unit_cost(task_properties::is_unit_cost(task_proxy)),
      max_time(opts.get<double>("max_time")),
      best_solved_state(StateID::no_state),
      best_solved_cost(EvaluationResult::INFTY) {
    if (opts.get<int>("bound") < 0) {
        cerr << "error: negative cost bound " << opts.get<int>("bound") << endl;
        utils::exit_with(ExitCode::SEARCH_INPUT_ERROR);
    }
    bound = opts.get<int>("bound");
    if (verbosity > utils::Verbosity::SILENT)
        task_properties::print_variable_statistics(task_proxy);
}

SearchEngine::~SearchEngine() {
}

bool SearchEngine::found_solution() const {
    return solution_found;
}

SearchStatus SearchEngine::get_status() const {
    return status;
}

const Plan &SearchEngine::get_plan() const {
    assert(solution_found);
    return plan;
}

void SearchEngine::set_plan(const Plan &p) {
    solution_found = true;
    plan = p;
}

void SearchEngine::search() {
    initialize();
    utils::CountdownTimer timer(max_time);
    while (status == IN_PROGRESS) {
        status = step();
        if (timer.is_expired()) {
            if (verbosity > utils::Verbosity::SILENT)
                cout << "Time limit reached. Abort search." << endl;
            status = TIMEOUT;
            break;
        }
    }
    if (verbosity > utils::Verbosity::SILENT)
        cout << "Actual search time: " << timer.get_elapsed_time()
             << " [t=" << utils::g_timer << "]" << endl;
}

bool SearchEngine::check_goal_and_set_plan(const GlobalState &state) {
    SearchNode node = search_space.get_node(state);
    int cost = node.get_real_g();
    if (cost >= best_solved_cost || task_properties::is_goal_state(task_proxy, state)) {
        Plan plan;
        if (cost >= best_solved_cost) {
            cost = best_solved_cost;
            search_space.trace_path(state_registry.lookup_state(best_solved_state), plan);
        } else {
            search_space.trace_path(state, plan);
        }
        if (verbosity > utils::Verbosity::SILENT) {
            cout << "Solution found! Cost: " << cost << endl;
        }
        set_plan(plan);
        return true;
    }
    return false;
}

void SearchEngine::save_plan_if_necessary() {
    if (found_solution()) {
        plan_manager.save_plan(get_plan(), task_proxy);
    }
}

void SearchEngine::save_task_if_necessary() {
    // Does not change task.
}

void SearchEngine::clear() {
    best_solved_state = StateID::no_state;
    best_solved_cost = EvaluationResult::INFTY;
    solution_found = false;
    status = IN_PROGRESS;
    plan.clear();
    state_registry.clear();
    search_space.clear();
    search_progress.clear();
    statistics.clear();
}

int SearchEngine::get_adjusted_cost(const OperatorProxy &op) const {
    return get_adjusted_action_cost(op, cost_type, is_unit_cost);
}

/* TODO: merge this into add_options_to_parser when all search
         engines support pruning.

   Method doesn't belong here because it's only useful for certain derived classes.
   TODO: Figure out where it belongs and move it there. */
void SearchEngine::add_pruning_option(OptionParser &parser) {
    parser.add_option<shared_ptr<PruningMethod>>(
        "pruning",
        "Pruning methods can prune or reorder the set of applicable operators in "
        "each state and thereby influence the number and order of successor states "
        "that are considered.",
        "null()");
}

void SearchEngine::add_options_to_parser(OptionParser &parser) {
    ::add_cost_type_option_to_parser(parser);
    parser.add_option<int>(
        "bound",
        "exclusive depth bound on g-values. Cutoffs are always performed according to "
        "the real cost, regardless of the cost_type parameter", "infinity");
    parser.add_option<double>(
        "max_time",
        "maximum time in seconds the search is allowed to run for. The "
        "timeout is only checked after each complete search step "
        "(usually a node expansion), so the actual runtime can be arbitrarily "
        "longer. Therefore, this parameter should not be used for time-limiting "
        "experiments. Timed-out searches are treated as failed searches, "
        "just like incomplete search algorithms that exhaust their search space.",
        "infinity");
    parser.add_option<bool>(
        "undef_value",
        "true to support 'undefined' variable values",
        "false");
    utils::add_verbosity_option_to_parser(parser);
}

/* Method doesn't belong here because it's only useful for certain derived classes.
   TODO: Figure out where it belongs and move it there. */
void SearchEngine::add_succ_order_options(OptionParser &parser) {
    vector<string> options;
    parser.add_option<bool>(
        "randomize_successors",
        "randomize the order in which successors are generated",
        "false");
    parser.add_option<bool>(
        "preferred_successors_first",
        "consider preferred operators first",
        "false");
    parser.document_note(
        "Successor ordering",
        "When using randomize_successors=true and "
        "preferred_successors_first=true, randomization happens before "
        "preferred operators are moved to the front.");
    utils::add_rng_options(parser);
}

void print_initial_evaluator_values(const EvaluationContext &eval_context) {
    eval_context.get_cache().for_each_evaluator_result(
        [] (const Evaluator *eval, const EvaluationResult &result) {
            if (eval->is_used_for_reporting_minima()) {
                eval->report_value_for_initial_state(result);
            }
        }
        );
}

static PluginTypePlugin<SearchEngine> _type_plugin(
    "SearchEngine",
    // TODO: Replace empty string by synopsis for the wiki page.
    "");

void collect_preferred_operators(
    EvaluationContext &eval_context,
    Evaluator *preferred_operator_evaluator,
    ordered_set::OrderedSet<OperatorID> &preferred_operators) {
    if (!eval_context.is_evaluator_value_infinite(preferred_operator_evaluator)) {
        for (OperatorID op_id : eval_context.get_preferred_operators(preferred_operator_evaluator)) {
            preferred_operators.insert(op_id);
        }
    }
}

const options::Options& SearchEngine::get_options() const {
    return opts;
}