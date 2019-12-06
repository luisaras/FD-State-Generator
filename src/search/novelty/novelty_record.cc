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

int NoveltyRecord::get_value(const std::vector<int>& state_values, uint h) {
    vector<FactPair> tuple(level);
    if (h >= reached_facts.size())
        reached_facts.resize(h + 1);
    int level = this->level;
    this->level = 0;
    while (this->level < level) {
        if (get_value(tuple, 0, reached_facts[h], state_values) > 0) {
            int value = level - this->level;
            this->level = level;
            return value; 
        }
        this->level++;
    }
    return 0;
}

int NoveltyRecord::get_value(vector<FactPair>& tuple, int l, set<vector<FactPair>>& reached_facts, const vector<int>& state_values) {
    if (l > level) {
        if (reached_facts.count(tuple) == 0) {
            reached_facts.insert(tuple);
            return 1;
        }
        return 0;
    }
    int value = 0;
    for (uint i = l; i < state_values.size(); i++) {
        if (state_values[i] < 0 || state_values[i] >= task->get_variable_domain_size(i))
            continue;
        tuple[l].var = i;
        tuple[l].value = state_values[i];
        value += get_value(tuple, l + 1, reached_facts, state_values);
    }
    return value;
}

}