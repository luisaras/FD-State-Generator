#ifndef NOVELTY_RECORD_H
#define NOVELTY_RECORD_H

#include <vector>
#include <set>
#include "../abstract_task.h"

namespace novelty {
class NoveltyRecord {
    const std::shared_ptr<AbstractTask> task;
    int level;
    bool use_h;
    std::vector<std::set<std::vector<FactPair>>> reached_facts;
protected:
    int get_value_1(std::set<std::vector<FactPair>>& reached_facts, const std::vector<int>& state_values);
    int get_value_2(std::set<std::vector<FactPair>>& reached_facts, const std::vector<int>& state_values);
    int get_value_3(std::set<std::vector<FactPair>>& reached_facts, const std::vector<int>& state_values);
public:
    NoveltyRecord(const std::shared_ptr<AbstractTask>& task, int level = 1, bool use_h = false);
    virtual ~NoveltyRecord() = default;
    
    virtual void clear();
    virtual int get_value(const std::vector<int>& state_values, int h = 0);
};
}

#endif