#include "novelty_heuristic.h"

#include "../global_state.h"
#include "../option_parser.h"
#include "../plugin.h"

#include "../tasks/root_task.h"
#include "../task_utils/task_properties.h"

#include <cstddef>
#include <limits>
#include <utility>

using namespace std;

namespace novelty {
    
options::Options get_default_opts(int level, bool use_h, bool prune, bool reverse) {
    Options opts;
    opts.set("level", level);
    opts.set("use_h", use_h);
    opts.set("prune", prune);
    opts.set("reverse", reverse);
    opts.set("transform", tasks::g_root_task);
    opts.set("cache_estimates", true);
    return opts;
}

NoveltyHeuristic::NoveltyHeuristic(const options::Options &opts)
    : Heuristic(opts),
      record(task, opts.get<int>("level", 1), opts.get<bool>("use_h", false)),
      prune(opts.get<bool>("prune", true)),
      reverse(opts.get<bool>("reverse", false)),
      num_facts(0) {
    cout << "Initializing novelty heuristic..." << endl;
    if (!reverse)
        for (int i = task->get_num_variables() - 1; i >= 0; i--)
            num_facts += task->get_variable_domain_size(i);
}

NoveltyHeuristic::NoveltyHeuristic(int level, bool use_h, bool prune, bool reverse) :
    NoveltyHeuristic(get_default_opts(level, use_h, prune, reverse)) {
}

int NoveltyHeuristic::compute_heuristic(const GlobalState &global_state) {
    State state = convert_global_state(global_state);
    int value = record.get_value(state.get_values());
    if (prune && value == 0)
        return DEAD_END;
    if (reverse)
        value = -value;
    return num_facts - value;
}

void NoveltyHeuristic::clear() {
    Heuristic::clear();
    record.clear();
}

void NoveltyHeuristic::add_options_to_parser(options::OptionParser &parser) {
    parser.add_option<int>("level", "", "1");
    parser.add_option<bool>("use_h", "", "false");
    parser.add_option<bool>("prune", "", "true");
    parser.add_option<bool>("reverse", "", "false");
}

static shared_ptr<Heuristic> _parse(options::OptionParser &parser) {
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

    NoveltyHeuristic::add_options_to_parser(parser);
    Heuristic::add_options_to_parser(parser);
    
    Options opts = parser.parse();
    if (parser.dry_run())
        return nullptr;
    else
        return make_shared<NoveltyHeuristic>(opts);
}

static Plugin<Evaluator> _plugin("novelty_h", _parse);
}
