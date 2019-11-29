#include "pattern_generator_greedy.h"

#include "pattern_information.h"
#include "utils.h"

#include "../option_parser.h"
#include "../plugin.h"
#include "../task_proxy.h"

#include "../task_utils/variable_order_finder.h"
#include "../utils/logging.h"
#include "../utils/math.h"
#include "../utils/timer.h"

#include <iostream>
#include <limits>

using namespace std;

namespace pdbs {
PatternGeneratorGreedy::PatternGeneratorGreedy(const Options &opts)
    : PatternGeneratorGreedy(opts.get<int>("max_states"), opts.get<int>("max_memory")) {
}

PatternGeneratorGreedy::PatternGeneratorGreedy(int max_states, int max_memory)
    : max_states(max_states),
    max_memory(max_memory == -1 ? numeric_limits<int>::max() : max_memory) {
}

PatternInformation PatternGeneratorGreedy::generate(const shared_ptr<AbstractTask> &task) {
    utils::Timer timer;
    cout << "Generating a pattern using the greedy generator..." << endl;
    TaskProxy task_proxy(*task);
    Pattern pattern;
    variable_order_finder::VariableOrderFinder order(task_proxy, variable_order_finder::GOAL_CG_LEVEL);
    VariablesProxy variables = task_proxy.get_variables();

    int size = 1;
    while (true) {
        if (order.done())
            break;
        int next_var_id = order.next();
        VariableProxy next_var = variables[next_var_id];
        int next_var_size = next_var.get_domain_size();

        if (!utils::is_product_within_limit(size, next_var_size, max_states))
            break;

        if (!utils::is_product_within_limit(size, next_var_size, max_memory)) {
            cerr << "Too many variables! (Overflow occured): " << endl;
            cerr << pattern << endl;
            utils::exit_with(utils::ExitCode::SEARCH_CRITICAL_ERROR);
        }

        pattern.push_back(next_var_id);
        size *= next_var_size;
    }

    PatternInformation pattern_info(task_proxy, move(pattern));
    dump_pattern_generation_statistics(
        "Greedy generator", timer(), pattern_info);
    return pattern_info;
}

static shared_ptr<PatternGenerator> _parse(OptionParser &parser) {
    parser.add_option<int>(
        "max_states",
        "maximal number of abstract states in the pattern database.",
        "1000000",
        Bounds("1", "infinity"));
    parser.add_option<int>(
        "max_memory",
        "maximal memory the generator is allowed to use.",
        "infinity",
        Bounds("1", "infinity"));

    Options opts = parser.parse();
    if (parser.dry_run())
        return nullptr;

    return make_shared<PatternGeneratorGreedy>(opts);
}

static Plugin<PatternGenerator> _plugin("greedy", _parse);
}
