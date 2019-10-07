#ifndef HEURISTICS_COMPLEXITY_HEURISTIC_H
#define HEURISTICS_COMPLEXITY_HEURISTIC_H

#include "../heuristic.h"
#include "../search_engine.h"
#include "../evaluation_context.h"
#include "../evaluation_result.h"

namespace complexity_heuristic {
class ComplexityHeuristic : public Heuristic {
    std::shared_ptr<SearchEngine> engine; 
protected:
    virtual int compute_heuristic(const GlobalState &global_state);
public:
    ComplexityHeuristic(const options::Options &opts);
    ~ComplexityHeuristic();

    virtual EvaluationResult compute_result(
        EvaluationContext &eval_context) override;

    virtual void get_path_dependent_evaluators(std::set<Evaluator *> &) override {}

};
}

#endif
