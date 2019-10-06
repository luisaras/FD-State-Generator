#ifndef SEARCH_ENGINES_GENERATOR_ALL_GOALS_H
#define SEARCH_ENGINES_GENERATOR_ALL_GOALS_H

#include "state_generator.h"

namespace state_generator {
    
class GeneratorAllGoals : public StateGenerator {
protected:

    int goal_count = 0;
    virtual void insert_goals_recursive(uint var);

    virtual void initialize() override;
    virtual SearchStatus step() override;

public:
    explicit GeneratorAllGoals(const options::Options &opts);
    virtual ~GeneratorAllGoals() = default;

};

}

#endif
