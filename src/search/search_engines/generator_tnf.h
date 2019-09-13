#ifndef SEARCH_ENGINES_GENERATOR_TNF_H
#define SEARCH_ENGINES_GENERATOR_TNF_H

#include "state_generator.h"

class Evaluator;
class PruningMethod;

namespace options {
class OptionParser;
class Options;
}

namespace state_generator {
    
class GeneratorTNF : public StateGenerator {
protected:
    virtual void initialize() override;
    virtual SearchStatus step() override;

public:
    explicit GeneratorTNF(const options::Options &opts);
    virtual ~GeneratorTNF() = default;
    
};

}

#endif