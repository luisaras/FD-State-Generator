#ifndef SEARCH_ENGINES_GENERATOR_ABSTRACT_GOAL_H
#define SEARCH_ENGINES_GENERATOR_ABSTRACT_GOAL_H

#include "state_generator.h"

namespace state_generator {
    
class GeneratorAbstractGoal : public StateGenerator {

protected:

    virtual void initialize() override;
    virtual SearchStatus step() override;

public:
    explicit GeneratorAbstractGoal(const options::Options &opts);
    virtual ~GeneratorAbstractGoal() = default;

};

}

#endif
