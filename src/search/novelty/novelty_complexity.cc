#include "novelty_complexity.h"

#include "../global_state.h"
#include "../option_parser.h"
#include "../plugin.h"

#include "../search_engines/eager_search.h"

#include "../task_utils/task_properties.h"

#include <cstddef>
#include <limits>
#include <utility>

using namespace std;

namespace novelty {
NoveltyComplexity::NoveltyComplexity(const Options &opts)
    : Heuristic(opts),
      //eval(make_shared<NoveltyHeuristic>(opts)),
      record(task, opts.get<int>("level"), opts.get<bool>("use_h")) {
    cout << "Initializing novelty complexity heuristic..." << endl;
    //search_opts.set("max_time", opts.get<int>("max_time"));
}

EvaluationResult NoveltyComplexity::compute_result(EvaluationContext &eval_context) {
    //search_opts.set("bound", eval_context.get_g_value());
    return Heuristic::compute_result(eval_context);
}

int NoveltyComplexity::compute_heuristic(const GlobalState &global_state) {
    State state = convert_global_state(global_state);
    /*eager_search::EagerSearch engine(search_opts);
    engine.get_registry().get_task_proxy().set_initial_state(state);
    engine.search();
    if (engine.found_solution()) {
        return engine.get_plan().size();
    } else {
        return DEAD_END;
    }*/
    int length = 0;
    int improved;
    vector<int> values;
    do {
        if (task_properties::is_goal_state(task_proxy, state))
            return length;
        improved = false;
        vector<OperatorID> applicable_ops;
        for (OperatorID op_id : applicable_ops) {
            State successor = state.get_successor(task_proxy.get_operators()[op_id]);
            if (record.get_value(successor.get_values()) > 0) {
                improved = true;
                values = successor.get_values();
                state = State(*task, move(values));
                length++;
                break;
            }
        }
    } while (improved);
    return DEAD_END;
}

static shared_ptr<Heuristic> _parse(OptionParser &parser) {
    parser.document_synopsis("Novelty complexity heuristic",
                             "Returns the length of the path found using only novelty. "
                             "Infinity if no path was found.");
    parser.document_language_support("action costs", "supported");
    parser.document_language_support("conditional effects", "supported");
    parser.document_language_support("axioms", "supported");
    parser.document_property("admissible", "no");
    parser.document_property("consistent", "no");
    parser.document_property("safe", "no");
    parser.document_property("preferred operators", "no");

    NoveltyHeuristic::add_options_to_parser(parser);
    Heuristic::add_options_to_parser(parser);
    
    Options opts = parser.parse();
    if (parser.dry_run())
        return nullptr;
    else
        return make_shared<NoveltyHeuristic>(opts);
}

static Plugin<Evaluator> _plugin("novelty_complexity", _parse);
}
