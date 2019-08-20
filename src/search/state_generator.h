#include "../tasks/modified_init_task.h"
#include "evaluator.h"

#include "../option_parser.h"

class StateGenerator {
	
	double max_time;
	std::shared_ptr<Evaluator> f_evaluator;

public:

	StateGenerator(const options::Options &opts);

	const std::shared_ptr<AbstractTask> generate(const std::shared_ptr<AbstractTask> &original_task) const;

	static void add_options_to_parser(options::OptionParser &parser);

};