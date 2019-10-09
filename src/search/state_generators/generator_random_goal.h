#ifndef SEARCH_ENGINES_GENERATOR_RANDOM_GOAL_H
#define SEARCH_ENGINES_GENERATOR_RANDOM_GOAL_H

#include "state_generator.h"

class Evaluator;
class PruningMethod;

namespace options {
class OptionParser;
class Options;
}

namespace state_generator {
    
class GeneratorRandomGoal : public StateGenerator {
protected:

    // Generation of candidate goal state
    std::vector<int> current_best_state;
    std::vector<int> current_best_state_eval;
    int convergence_max;
    int convergence_count = 0;

    virtual void initialize() override;
    virtual SearchStatus step() override;
    virtual bool on_list_empty() override;
    virtual bool update_best_state(EvaluationContext& eval_context, const std::vector<int>& state) override;

public:
    explicit GeneratorRandomGoal(const options::Options &opts);
    virtual ~GeneratorRandomGoal() = default;
    
    static void add_options_to_parser(options::OptionParser &parser);

};

}

#endif