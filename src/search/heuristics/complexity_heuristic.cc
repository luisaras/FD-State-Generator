#include "complexity_heuristic.h"

#include "../global_state.h"
#include "../option_parser.h"
#include "../plugin.h"

#include "../utils/logging.h"

#include "../task_utils/task_properties.h"

#include <cstddef>
#include <limits>
#include <utility>

using namespace std;

namespace complexity_heuristic {
ComplexityHeuristic::ComplexityHeuristic(const Options &opts)
    : Heuristic(opts),
      engine(opts.get<shared_ptr<SearchEngine>>("engine")),
      bound_g(opts.get<bool>("bound", false)) {
    cout << "Initializing complexity heuristic..." << endl;
}

ComplexityHeuristic::~ComplexityHeuristic() {
}

int bound;

EvaluationResult ComplexityHeuristic::compute_result(EvaluationContext &eval_context) {
    bound = eval_context.get_g_value();
    return Heuristic::compute_result(eval_context);
}

int ComplexityHeuristic::compute_heuristic(const GlobalState &global_state) {
    State state = convert_global_state(global_state);

    engine->get_registry().get_task_proxy().set_initial_state(state);
    engine->clear();
    for (VariableProxy var : engine->get_registry().get_task_proxy().get_variables()) {
        assert(state.get_values()[var.get_id()] < var.get_domain_size());
    }
    
    if (bound_g)
        engine->set_bound(bound + 1);
    engine->search();

    if (engine->found_solution()) {
        return engine->get_plan().size();
    } else {
        //cout << "Dead end: " << state.get_values() 
        //    << " " << engine->get_statistics().get_expanded()
        //    << " " << engine->get_statistics().get_generated()
        //    << endl;
        return DEAD_END;
    }
}

static shared_ptr<Heuristic> _parse(OptionParser &parser) {
    parser.document_synopsis("Complexity heuristic",
                             "Returns length of path found using given search engine. "
                             "Dead end if no path is found.");
    parser.document_language_support("action costs", "supported");
    parser.document_language_support("conditional effects", "supported");
    parser.document_language_support("axioms", "supported");
    parser.document_property("admissible", "no");
    parser.document_property("consistent", "no");
    parser.document_property("safe", "no");
    parser.document_property("preferred operators", "no");

    parser.add_option<shared_ptr<SearchEngine>>("engine", "search engine");
    parser.add_option<bool>("bound", "bound by node's g-value", "false");
    Heuristic::add_options_to_parser(parser);
    Options opts = parser.parse();
    if (parser.dry_run())
        return nullptr;
    else
        return make_shared<ComplexityHeuristic>(opts);
}

static Plugin<Evaluator> _plugin("complexity", _parse);
}
