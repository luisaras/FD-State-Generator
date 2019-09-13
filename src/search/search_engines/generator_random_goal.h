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
    int current_best_state_h;
    int convergence_max;
    int convergence_count = 0;
    
    virtual bool next_goal_state();

    virtual void initialize() override;
    virtual SearchStatus step() override;

public:
    explicit GeneratorRandomGoal(const options::Options &opts);
    virtual ~GeneratorRandomGoal() = default;
    
    static void add_options_to_parser(options::OptionParser &parser);

};

}

#endif