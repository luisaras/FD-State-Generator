#ifndef SEARCH_ENGINES_GENERATOR_ABSTRACT_GOAL_H
#define SEARCH_ENGINES_GENERATOR_ABSTRACT_GOAL_H

#include "state_generator.h"

class Evaluator;
class PruningMethod;

namespace options {
class OptionParser;
class Options;
}

namespace state_generator {
    
class GeneratorAbstractGoal : public StateGenerator {

	uint undef_variable_count;

protected:

    virtual void initialize() override;
    virtual SearchStatus step() override;

public:
    explicit GeneratorAbstractGoal(const options::Options &opts);
    virtual ~GeneratorAbstractGoal() = default;

};

}

#endif
