#include "state_generator.h"
#include "search_common.h"

#include "../option_parser.h"
#include "../plugin.h"

using namespace std;

namespace plugin_generator {
    
static shared_ptr<SearchEngine> _parse(OptionParser &parser) {
    parser.document_synopsis(
        "State Generator",
        "");

    state_generator::add_options_to_parser(parser);
    Options opts = parser.parse();

    shared_ptr<state_generator::StateGenerator> engine;
    if (!parser.dry_run()) {
        opts.set("open", search_common::create_reverse_open_list_factory(opts));
        engine = make_shared<state_generator::StateGenerator>(opts);
    }

    return engine;
}

static Plugin<SearchEngine> _plugin("generator", _parse);
}
