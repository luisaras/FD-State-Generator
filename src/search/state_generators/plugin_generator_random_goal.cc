#include "generator_random_goal.h"

#include "../search_engines/search_common.h"

#include "../option_parser.h"
#include "../plugin.h"

using namespace std;

namespace plugin_generator_random_goal {
static shared_ptr<SearchEngine> _parse(OptionParser &parser) {
    parser.document_synopsis("State Generator (Random Goal)","");
    state_generator::StateGenerator::add_options_to_parser(parser);
    state_generator::GeneratorRandomGoal::add_options_to_parser(parser);
    Options opts = parser.parse();
    shared_ptr<state_generator::StateGenerator> engine;
    if (!parser.dry_run()) {
        opts.set("open", search_common::create_reverse_open_list_factory(opts));
        engine = make_shared<state_generator::GeneratorRandomGoal>(opts);
    }
    return engine;
}
static Plugin<SearchEngine> _plugin("generator_random", _parse);
}
