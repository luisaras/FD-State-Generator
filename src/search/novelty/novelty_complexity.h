#ifndef NOVELTY_COMPLEXITY_HEURISTIC_H
#define NOVELTY_COMPLEXITY_HEURISTIC_H

#include "../heuristic.h"
#include "novelty_heuristic.h"
#include "../option_parser.h"

namespace novelty {
class NoveltyComplexity : public Heuristic {
    //options::Options search_opts;
    //std::shared_ptr<NoveltyHeuristic> eval;
    NoveltyRecord record;
protected:
    virtual int compute_heuristic(const GlobalState &global_state);
public:
    NoveltyComplexity(const options::Options &opts);
    ~NoveltyComplexity() = default;

    virtual EvaluationResult compute_result(
        EvaluationContext &eval_context) override;

    virtual void get_path_dependent_evaluators(std::set<Evaluator *> &) override {}
    
};
}

#endif
