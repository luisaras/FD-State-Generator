#include "novelty_heuristic.h"

#include "../global_state.h"
#include "../option_parser.h"
#include "../plugin.h"

#include "../task_utils/task_properties.h"

#include <cstddef>
#include <limits>
#include <utility>

using namespace std;

namespace novelty {
NoveltyHeuristic::NoveltyHeuristic(const Options &opts)
    : Heuristic(opts),
      record(task, opts.get<int>("level", 1), opts.get<bool>("use_h", false)),
      num_facts(0) {
    cout << "Initializing novelty heuristic..." << endl;
    for (int i = task->get_num_variables() - 1; i >= 0; i--)
        num_facts += task->get_variable_domain_size(i);
}

int NoveltyHeuristic::compute_heuristic(const GlobalState &global_state) {
    State state = convert_global_state(global_state);
    return num_facts - record.get_value(state.get_values());
}

static shared_ptr<Heuristic> _parse(OptionParser &parser) {
    parser.document_synopsis("Novelty heuristic",
                             "Returns the total number of fact minus"
                             "the novelty value of given state");
    parser.document_language_support("action costs", "supported");
    parser.document_language_support("conditional effects", "supported");
    parser.document_language_support("axioms", "supported");
    parser.document_property("admissible", "no");
    parser.document_property("consistent", "no");
    parser.document_property("safe", "no");
    parser.document_property("preferred operators", "no");

    Heuristic::add_options_to_parser(parser);
    parser.add_option<int>("level", "", "1");
    parser.add_option<bool>("use_h", "", "false");
    
    Options opts = parser.parse();
    if (parser.dry_run())
        return nullptr;
    else
        return make_shared<NoveltyHeuristic>(opts);
}

static Plugin<Evaluator> _plugin("novelty", _parse);
}
