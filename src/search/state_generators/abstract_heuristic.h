#ifndef ABSTRACT_HEURISTIC_H
#define ABSTRACT_HEURISTIC_H

#include "../heuristic.h"

namespace abstract_heuristic {
class AbstractHeuristic : public Heuristic {
    int min_operator_cost;
    std::shared_ptr<Evaluator> concrete_evaluator;

    uint concrete_state_count = 0;
    
protected:
    virtual int compute_heuristic(const GlobalState &global_state);
public:
    AbstractHeuristic(const options::Options &opts);
    ~AbstractHeuristic();

    virtual bool dead_ends_are_reliable() const override;
    virtual EvaluationResult compute_result(
        EvaluationContext &eval_context) override;
    virtual void get_path_dependent_evaluators(std::set<Evaluator *> &evals) override;
};
}

#endif
