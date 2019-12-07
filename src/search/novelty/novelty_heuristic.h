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
    bool reverse;
    std::shared_ptr<Evaluator> eval;
protected:
    virtual int compute_heuristic(const GlobalState &global_state);
public:
    NoveltyHeuristic(const options::Options &opts);
    NoveltyHeuristic(int level, std::shared_ptr<Evaluator>& eval, bool prune, bool reverse);
    ~NoveltyHeuristic() = default;

    static void add_options_to_parser(options::OptionParser &parser);
    
	virtual void clear() override;

};
}

#endif
