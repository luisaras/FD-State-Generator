#include "undefs_heuristic.h"

#include "../option_parser.h"
#include "../plugin.h"
#include "../global_state.h"

#include "../task_utils/task_properties.h"

#include <cassert>
#include <cstddef>
#include <limits>
#include <utility>

using namespace std;

namespace undefs_heuristic {

UndefsHeuristic::UndefsHeuristic(const Options &opts)
    : Heuristic(opts) {
    num_variables = task_proxy.get_variables().size();
    undef_variable_count = num_variables - task_proxy.get_goals().size();
}

UndefsHeuristic::~UndefsHeuristic() {
}

int UndefsHeuristic::compute_heuristic(const GlobalState &global_state) {
    State state = convert_global_state(global_state);
    VariablesProxy variables = task_proxy.get_variables();
    const vector<int> &values = state.get_values();
    // Count undefined variables
    int last_undef_var = -1;
    uint undefs = 0;
    for (uint i = 0; i < values.size(); ++i) {
        if (values[i] >= variables[i].get_domain_size()) {
            undefs++;
            last_undef_var = i;
        }
    }
    // Update undef count
    if (undefs < undef_variable_count) {
        cout << "New undef count: " << undefs << endl;
        undef_variable_count = undefs;
        if (undefs == 1)
            cout << "Last undef var: " << last_undef_var << endl;
    }
    return num_variables - undefs;
}

static shared_ptr<Heuristic> _parse(OptionParser &parser) {
    parser.document_synopsis("Undefs evaluator",
                             "Retuns the number of defined variables.");
    Heuristic::add_options_to_parser(parser);
    Options opts = parser.parse();

    if (parser.dry_run())
        return nullptr;
    else
        return make_shared<UndefsHeuristic>(opts);
}

static Plugin<Evaluator> _plugin("undefs", _parse);

}
