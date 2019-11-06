#include "novelty_record.h"

using namespace std;

namespace novelty {
NoveltyRecord::NoveltyRecord(const std::shared_ptr<AbstractTask>& task, int level, bool use_h) : 
    task(task), level(level), use_h(use_h) {
    clear();
}

void NoveltyRecord::clear() {
    reached_facts.clear();
    set<vector<FactPair>> initial_set;
    reached_facts.push_back(initial_set);
}

int NoveltyRecord::get_value(const std::vector<int>& state_values, int h) {
    switch(level) {
        case 1:
            return get_value_1(reached_facts[h], state_values);
            break;
        case 2:
            return get_value_2(reached_facts[h], state_values);
            break;
        default:
            return get_value_3(reached_facts[h], state_values);
            break;
    }
}

int NoveltyRecord::get_value_1(set<vector<FactPair>>& reached_facts, const vector<int>& state_values) {
    int value = 0;
    for (uint i = 0; i < state_values.size(); i++) {
        if (state_values[i] < 0 || state_values[i] >= task->get_variable_domain_size(i))
            continue;
        vector<FactPair> fact;
        fact.emplace_back(i, state_values[i]);
        if (reached_facts.count(fact) == 0) {
            reached_facts.insert(fact);
            value++;
        }
    }
    return value;
}

int NoveltyRecord::get_value_2(set<vector<FactPair>>& reached_facts, const vector<int>& state_values) {
    int value = 0;
    for (uint i = 0; i < state_values.size(); i++) {
        if (state_values[i] < 0 || state_values[i] >= task->get_variable_domain_size(i))
            continue;
        vector<FactPair> fact;
        fact.emplace_back(i, state_values[i]);
        if (reached_facts.count(fact) == 0) {
            reached_facts.insert(fact);
            value++;
        }
        fact.resize(2);
        for (uint j = i + 1; j < state_values.size(); j++) {
            if (state_values[j] < 0 || state_values[j] >= task->get_variable_domain_size(j))
                continue;
            fact[1] = FactPair(j, state_values[j]);
            if (reached_facts.count(fact) == 0) {
                reached_facts.insert(fact);
                value++;
            }
        }
    }
    return value;
}

int NoveltyRecord::get_value_3(set<vector<FactPair>>& reached_facts, const vector<int>& state_values) {
    int value = 0;
    for (uint i = 0; i < state_values.size(); i++) {
        if (state_values[i] < 0 || state_values[i] >= task->get_variable_domain_size(i))
            continue;
        vector<FactPair> fact;
        fact.emplace_back(i, state_values[i]);
        if (reached_facts.count(fact) == 0) {
            reached_facts.insert(fact);
            value++;
        }
        fact.resize(2);
        for (uint j = i + 1; j < state_values.size(); j++) {
            if (state_values[j] < 0 || state_values[j] >= task->get_variable_domain_size(j))
                continue;
            fact[1] = FactPair(j, state_values[j]);
            if (reached_facts.count(fact) == 0) {
                reached_facts.insert(fact);
                value++;
            }
            fact.resize(3);
            for (uint k = j + 1; k < state_values.size(); k++) {
                if (state_values[k] < 0 || state_values[k] >= task->get_variable_domain_size(k))
                    continue;
                fact[2] = FactPair(k, state_values[k]);
                if (reached_facts.count(fact) == 0) {
                    reached_facts.insert(fact);
                    value++;
                }
            }
        }
    }
    return value;
}

}