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
    
protected:

    int max_it;
    int it_count = 0;

    std::unique_ptr<StateOpenList> open_list;

    std::shared_ptr<Evaluator> h_evaluator;
    std::vector<Evaluator*> path_dependent_evaluators;
    
    std::vector<reverse_search::ReverseOperator> operators;
    
    reverse_search::MatchTree match_tree;

    std::vector<int> best_state;
    int best_state_h;
    int original_state_h;

    virtual void initialize() override;
    
    virtual void reward_progress();

public:
    explicit StateGenerator(const options::Options &opts);
    virtual ~StateGenerator() = default;

    virtual void print_statistics() const override;
    virtual void save_plan_if_necessary() override;
    virtual void save_task_if_necessary() override;

    virtual bool found_solution() const override;

    void dump_search_space() const;
    
    static void add_options_to_parser(options::OptionParser &parser);
};

}

#endif
