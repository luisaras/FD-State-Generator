#ifndef UNDEFS_HEURISTIC_H
#define UNDEFS_HEURISTIC_H

#include "../heuristic.h"

namespace options {
class Options;
}

namespace undefs_heuristic {
class UndefsHeuristic : public Heuristic {

    uint undef_variable_count;
    uint num_variables;
    
protected:
    virtual int compute_heuristic(const GlobalState &global_state);
public:
    UndefsHeuristic(const options::Options &opts);
    ~UndefsHeuristic();
};
}

#endif
