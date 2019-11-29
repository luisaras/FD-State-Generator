#ifndef PDBS_PATTERN_GENERATOR_GREEDY_H
#define PDBS_PATTERN_GENERATOR_GREEDY_H

#include "pattern_generator.h"

namespace options {
class Options;
}

namespace pdbs {
class PatternGeneratorGreedy : public PatternGenerator {
    int max_states;
    int max_memory;
public:
    explicit PatternGeneratorGreedy(const options::Options &opts);
    explicit PatternGeneratorGreedy(int max_states, int max_memory = -1);
    virtual ~PatternGeneratorGreedy() = default;

    virtual PatternInformation generate(const std::shared_ptr<AbstractTask> &task) override;
};
}

#endif
