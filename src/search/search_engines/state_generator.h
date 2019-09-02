#ifndef SEARCH_ENGINES_STATE_GENERATOR_H
#define SEARCH_ENGINES_STATE_GENERATOR_H

#include "../open_list.h"
#include "../search_engine.h"
#include "match_tree.h"
#include "reverse_operator.h"

#include <memory>
#include <vector>

class Evaluator;
class PruningMethod;

namespace options {
class OptionParser;
class Options;
}

namespace state_generator {
    
class StateGenerator : public SearchEngine {
    const bool reopen_closed_nodes;

    std::unique_ptr<StateOpenList> open_list;

    std::vector<Evaluator *> path_dependent_evaluators;
    std::vector<std::shared_ptr<Evaluator>> preferred_operator_evaluators;
    std::shared_ptr<Evaluator> lazy_evaluator;
    
    std::vector<reverse_search::ReverseOperator> operators;
    
    reverse_search::MatchTree match_tree;
    
    std::vector<int> best_state;
    EvaluationContext best_state_eval;

    void reward_progress();

protected:
    virtual void initialize() override;
    virtual SearchStatus step() override;

public:
    explicit StateGenerator(const options::Options &opts);
    virtual ~StateGenerator() = default;

    virtual void print_statistics() const override;
    virtual void save_task_if_necessary() override;

    void dump_search_space() const;
};

extern void add_options_to_parser(options::OptionParser &parser);
}

#endif
