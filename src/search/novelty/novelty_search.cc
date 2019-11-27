#include "novelty_search.h"
#include "novelty_heuristic.h"

#include "../search_engines/search_common.h"

#include "../task_utils/task_properties.h"

#include "../option_parser.h"
#include "../plugin.h"

using namespace std;

namespace novelty {

Options& add_default_args (Options& opts) {
    // Create evaluator
    shared_ptr<Evaluator> eval = make_shared<NoveltyHeuristic>(
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

    opts.set("store_path", false);

    return opts;
}

NoveltySearch::NoveltySearch(
    const Options &opts)
    : eager_search::EagerSearch(opts),
    goal(opts.get<int>("goal")) {
    if (verbosity > utils::Verbosity::SILENT)
        cout << "Number of goals: " << task_proxy.get_goals().size() << endl;
}

NoveltySearch::~NoveltySearch() {
}

bool NoveltySearch::check_goal_and_set_plan(const GlobalState &state) {
    SearchNode node = search_space.get_node(state);
    if (goal == -1) {
        if (!task_properties::is_goal_state(task_proxy, state))
            return false;
    } else {
        FactPair goal_fact = task_proxy.get_goals()[goal].get_pair();
        if (state[goal_fact.var] != goal_fact.value)
            return false;
    }
    Plan plan;
    search_space.trace_path(state, plan);
    if (verbosity > utils::Verbosity::SILENT)
        cout << "Solution found! Cost: " << node.get_g() << endl;
    set_plan(plan);
    return true;
}

static shared_ptr<SearchEngine> _parse(OptionParser &parser) {
    parser.document_synopsis("Novelty search (eager)", "");
    
    novelty::NoveltyHeuristic::add_options_to_parser(parser);
    eager_search::add_options_to_parser(parser);
    parser.add_option<int>("goal", "Index of the goal fact", "-1");
    Options opts = parser.parse();

    shared_ptr<SearchEngine> engine;
    if (!parser.dry_run()) {
        add_default_args(opts);
        engine = make_shared<NoveltySearch>(opts);
    }
    return engine;
}

static Plugin<SearchEngine> _plugin("novelty_search", _parse);

}
