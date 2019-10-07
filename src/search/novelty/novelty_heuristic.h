#ifndef NOVELTY_HEURISTIC_H
#define NOVELTY_HEURISTIC_H

#include "../heuristic.h"
#include "novelty_record.h"

namespace options {
class OptionParser;
class Options;
}

namespace novelty {
class NoveltyHeuristic : public Heuristic {
    NoveltyRecord record;
    bool prune;
    int num_facts;
protected:
    virtual int compute_heuristic(const GlobalState &global_state);
public:
    NoveltyHeuristic(const options::Options &opts);
    NoveltyHeuristic(int level, bool use_h, bool prune);
    ~NoveltyHeuristic() = default;

    static void add_options_to_parser(options::OptionParser &parser);
    
};
}

#endif
