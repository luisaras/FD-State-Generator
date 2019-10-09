#ifndef SEARCH_ENGINES_STATE_GENERATOR_H
#define SEARCH_ENGINES_STATE_GENERATOR_H

#include "../open_list.h"
#include "../search_engine.h"
#include "match_tree.h"
#include "reverse_operator.h"

#include <optional.hh>
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
    
protected:

    int max_it;
    int it_count = 0;

    std::unique_ptr<StateOpenList> open_list;

    std::vector<std::shared_ptr<Evaluator>> evaluators;
    std::vector<Evaluator*> path_dependent_evaluators;
    
    std::vector<reverse_search::ReverseOperator> operators;
    
    reverse_search::MatchTree match_tree;

    std::vector<int> best_state;
    std::vector<int> best_state_eval;
    std::vector<int> original_state_eval;

    virtual void initialize() override;
    virtual bool pop_node(tl::optional<SearchNode> &node, std::vector<int> &state_values);
    virtual bool on_list_empty() { return false; }
    virtual std::vector<int> evaluator_values(EvaluationContext& eval_context);
    virtual bool update_best_state(EvaluationContext& eval_context, const std::vector<int>& state);

public:
    explicit StateGenerator(const options::Options &opts);
    virtual ~StateGenerator() = default;

    virtual void print_statistics() const override;
    virtual void save_plan_if_necessary() override;
    virtual void save_task_if_necessary() override;

    virtual bool found_solution() const override;

    void dump_state(std::vector<int>& state);
    void dump_search_space() const;
    
    static void add_options_to_parser(options::OptionParser &parser);
};

}

#endif
