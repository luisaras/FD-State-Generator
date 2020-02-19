#include "novelty_record.h"

using namespace std;

namespace novelty {
NoveltyRecord::NoveltyRecord(const std::shared_ptr<AbstractTask>& task, int level) : 
    task(task), level(level) {
    clear();
}

void NoveltyRecord::clear() {
    reached_facts.clear();
}

// reached_facts facts already found by search algorithm
// state_values values of each variable
// r number of elements they are missing in the set
// var last variable with undefined value
// d current index of the element to be set
bool subset(set<vector<FactPair>>& reached_facts, const std::vector<int>& state_values, int r, int var, int d, vector<FactPair>& tuple) {
    if (r == 0) {
        if (reached_facts.count(tuple) == 0) {
            reached_facts.insert(tuple);
            return true;
        } else {
            return false;
        }
    }
    bool is_new = false;
    for (uint i = var; i < state_values.size(); i++) {
        tuple[d].var = i;
        tuple[d].value = state_values[i];
        is_new = is_new | subset(reached_facts, state_values, r - 1, i + 1, d + 1, tuple);
    }
    return is_new;
}

int NoveltyRecord::get_value(const vector<int>& state_values, uint h) {
    if (h >= reached_facts.size())
        reached_facts.resize(h + 1);
    vector<FactPair> tuple;
    for (int l = 1; l <= level; l++) {
        tuple.resize(l);
        if (subset(reached_facts[h], state_values, l, 0, 0, tuple)) {
            return level - l + 1;
        }
    }
    return 0;
}

}