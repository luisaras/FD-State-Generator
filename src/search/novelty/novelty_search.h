#ifndef SEARCH_ENGINES_NOVETLY_SEARCH_H
#define SEARCH_ENGINES_NOVELTY_SEARCH_H

#include "../search_engines/eager_search.h"
#include "../option_parser.h"
#include "../utils/logging.h"

namespace novelty {

class NoveltySearch : public eager_search::EagerSearch {

protected:
    int goal;
    
    virtual bool check_goal_and_set_plan(const GlobalState &state);

public:
    explicit NoveltySearch(const options::Options &opts);
    virtual ~NoveltySearch() override;
};

}

#endif
