#include "state_generator.h"

StateGenerator::StateGenerator(const options::Options &opts) :
	max_time(opts.get<double>("r_max_time")) {
}

const std::shared_ptr<AbstractTask> StateGenerator::generate(const std::shared_ptr<AbstractTask> &original_task) const {
	std::vector<int> initial_state_values = original_task->get_initial_state_values();
	std::shared_ptr<AbstractTask> new_task = std::make_shared<extra_tasks::ModifiedInitTask>(original_task, initial_state_values);
	return new_task;
}

void StateGenerator::add_options_to_parser(options::OptionParser &parser) {
    parser.add_option<double>(
        "r_max_time",
        "maximum time in seconds the search is allowed to run for. The "
        "timeout is only checked after each complete search step "
        "(usually a node expansion), so the actual runtime can be arbitrarily "
        "longer. Therefore, this parameter should not be used for time-limiting "
        "experiments.",
        "infinity");
}