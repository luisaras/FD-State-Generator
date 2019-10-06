#ifndef NOVELTY_HEURISTIC_H
#define NOVELTY_HEURISTIC_H

#include "../heuristic.h"
#include "novelty_record.h"

namespace novelty {
class NoveltyHeuristic : public Heuristic {
    NoveltyRecord record;
    int num_facts;
protected:
    virtual int compute_heuristic(const GlobalState &global_state);
public:
    NoveltyHeuristic(const options::Options &opts);
    ~NoveltyHeuristic() = default;
};
}

#endif
