#ifndef SEARCH_ENGINE_H
#define SEARCH_ENGINE_H

#include "operator_cost.h"
#include "operator_id.h"
#include "plan_manager.h"
#include "search_progress.h"
#include "search_space.h"
#include "search_statistics.h"
#include "state_registry.h"
#include "task_proxy.h"
#include "option_parser.h"

#include <vector>

namespace ordered_set {
template<typename T>
class OrderedSet;
}

namespace successor_generator {
class SuccessorGenerator;
}

namespace utils {
enum class Verbosity;
}

enum SearchStatus {IN_PROGRESS, TIMEOUT, FAILED, SOLVED};

class SearchEngine {
    SearchStatus status;
    bool solution_found;
    Plan plan;
protected:

    const options::Options opts;

    // Hold a reference to the task implementation and pass it to objects that need it.
    const std::shared_ptr<AbstractTask> task;
    // Use task_proxy to access task information.
    TaskProxy task_proxy;

    PlanManager plan_manager;
    StateRegistry state_registry;
    const successor_generator::SuccessorGenerator &successor_generator;
    SearchSpace search_space;
    SearchProgress search_progress;
    SearchStatistics statistics;
    int bound;
    OperatorCost cost_type;
    bool is_unit_cost;
    double max_time;
    utils::Verbosity verbosity;

    virtual void initialize() {}
    virtual SearchStatus step() = 0;

    void set_plan(const Plan &plan);
    bool check_goal_and_set_plan(const GlobalState &state);
    int get_adjusted_cost(const OperatorProxy &op) const;
public:
    SearchEngine(const options::Options &opts);
    virtual ~SearchEngine();

    virtual void search();
    virtual void print_statistics() const = 0;
    virtual bool found_solution() const;
    virtual void save_plan_if_necessary();
    virtual void save_task_if_necessary();
    virtual void clear();

    PlanManager &get_plan_manager() {return plan_manager;}
    StateRegistry &get_registry() {return state_registry;}
    const SearchStatistics &get_statistics() const {return statistics;}

    const options::Options& get_options() const;
    SearchStatus get_status() const;
    const Plan &get_plan() const;
    
    void set_bound(int b) {bound = b;}
    int get_bound() {return bound;}
    void set_verbosity(utils::Verbosity v) {verbosity = v;}
    utils::Verbosity get_verbosity() {return verbosity;}



    /* The following three methods should become functions as they
       do not require access to private/protected class members. */
    static void add_pruning_option(options::OptionParser &parser);
    static void add_options_to_parser(options::OptionParser &parser);
    static void add_succ_order_options(options::OptionParser &parser);
};

/*
  Print evaluator values of all evaluators evaluated in the evaluation context.
*/
extern void print_initial_evaluator_values(const EvaluationContext &eval_context);

extern void collect_preferred_operators(
    EvaluationContext &eval_context, Evaluator *preferred_operator_evaluator,
    ordered_set::OrderedSet<OperatorID> &preferred_operators);

#endif
