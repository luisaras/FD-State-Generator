#include "abstract_heuristic.h"

#include "../option_parser.h"
#include "../plugin.h"
#include "../global_state.h"

#include "../task_utils/task_properties.h"

#include <cassert>
#include <cstddef>
#include <limits>
#include <utility>

using namespace std;

namespace abstract_heuristic {

AbstractHeuristic::AbstractHeuristic(const Options &opts)
    : Heuristic(opts), 
    min_operator_cost(task_properties::get_min_operator_cost(task_proxy)),
    concrete_evaluator(opts.get<shared_ptr<Evaluator>>("eval")) {
}

AbstractHeuristic::~AbstractHeuristic() {
}

EvaluationResult AbstractHeuristic::compute_result(
    EvaluationContext &eval_context) {
        
    EvaluationResult result = Heuristic::compute_result(eval_context);
    if (result.get_evaluator_value() == EvaluationResult::INFTY) {
        return concrete_evaluator->compute_result(eval_context);
    }
    return result;
}

int AbstractHeuristic::compute_heuristic(const GlobalState &global_state) {
    State state = convert_global_state(global_state);
    if (task_properties::is_goal_state(task_proxy, state)) {
        return 0;
    } else {
        VariablesProxy variables = task_proxy.get_variables();
        const vector<int> &values = state.get_values();
        for (uint i = 0; i < values.size(); ++i) {
            if (values[i] >= variables[i].get_domain_size()) {
                //cout << "abstract " << i << endl;
                return min_operator_cost;
            }
        }
        return DEAD_END;
    }
}

bool AbstractHeuristic::dead_ends_are_reliable() const {
    return concrete_evaluator->dead_ends_are_reliable();
}

void AbstractHeuristic::get_path_dependent_evaluators(set<Evaluator *> &evals) {
    concrete_evaluator->get_path_dependent_evaluators(evals);
}

static shared_ptr<Heuristic> _parse(OptionParser &parser) {
    
    parser.document_synopsis("Abstract evaluator",
                             "Returns the same as blind if one of the variables is undefined.");

    parser.add_option<shared_ptr<Evaluator>>("eval", "heuristic for concrete states");
    Heuristic::add_options_to_parser(parser);
    Options opts = parser.parse();

    if (parser.dry_run())
        return nullptr;
    else
        return make_shared<AbstractHeuristic>(opts);
}

static Plugin<Evaluator> _plugin("abstract", _parse);

}
