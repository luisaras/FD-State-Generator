#include "generator_abstract_goal.h"

#include "../search_engines/search_common.h"

#include "abstract_heuristic.h"
#include "undefs_heuristic.h"

#include "../option_parser.h"
#include "../plugin.h"

#include "../tasks/root_task.h"

using namespace std;

namespace plugin_generator_abstract_goal {
static shared_ptr<SearchEngine> _parse(OptionParser &parser) {
    parser.document_synopsis("State Generator (Abstract Goal)","");
    state_generator::StateGenerator::add_options_to_parser(parser);
    Options opts = parser.parse();
    opts.set("undef_value", true);
    shared_ptr<state_generator::StateGenerator> engine;
    if (!parser.dry_run()) {
        Options h_opts;
        h_opts.set("transform", tasks::g_root_task);
        h_opts.set("cache_estimates", true);
        // Set tie-breaker
        vector<shared_ptr<Evaluator>> tiebreakers = opts.get_list<shared_ptr<Evaluator>>("tiebreakers");
        tiebreakers.push_back(make_shared<undefs_heuristic::UndefsHeuristic>(h_opts));
        opts.set("tiebreakers", tiebreakers);
        // Set evaluator to AbstractHeuristic
        h_opts.set("eval", opts.get<shared_ptr<Evaluator>>("eval"));
        shared_ptr<Evaluator> abstract_eval = make_shared<abstract_heuristic::AbstractHeuristic>(h_opts);
        opts.set("eval", abstract_eval);
        // Set open list
        opts.set("open", search_common::create_reverse_open_list_factory(opts));
        engine = make_shared<state_generator::GeneratorAbstractGoal>(opts);
    }
    return engine;
}
static Plugin<SearchEngine> _plugin("generator_abstract", _parse);
}
