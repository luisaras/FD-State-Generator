#include "../search_engines/eager_search.h" 
#include "../search_engines/search_common.h"
#include "novelty_heuristic.h"

#include "../option_parser.h"
#include "../plugin.h"

using namespace std;

namespace plugin_novelty {

static shared_ptr<SearchEngine> _parse(OptionParser &parser) {
    parser.document_synopsis("Novelty search (eager)", "");
    
    novelty::NoveltyHeuristic::add_options_to_parser(parser);
    eager_search::add_options_to_parser(parser);
    Options opts = parser.parse();

    shared_ptr<eager_search::EagerSearch> engine;
    if (!parser.dry_run()) {
        
        // Create evaluator
        shared_ptr<Evaluator> eval = make_shared<novelty::NoveltyHeuristic>(
            opts.get<int>("level"), 
            opts.get<bool>("use_h"),
            opts.get<bool>("prune"),
            opts.get<bool>("reverse"));
        vector<shared_ptr<Evaluator>> evals = {eval};
        opts.set("evals", evals);
        opts.set("open", search_common::create_standard_scalar_open_list_factory(eval, false));
        
        // General eager search parameters
        opts.set("reopen_closed", false);
        shared_ptr<Evaluator> null_eval = nullptr;
        opts.set("f_eval", null_eval);
        vector<shared_ptr<Evaluator>> empty_list;
        opts.set("preferred", empty_list);
        
        engine = make_shared<eager_search::EagerSearch>(opts);
    }
    return engine;
}

static Plugin<SearchEngine> _plugin("novelty_search", _parse);

}