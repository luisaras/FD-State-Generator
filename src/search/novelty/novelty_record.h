#ifndef NOVELTY_RECORD_H
#define NOVELTY_RECORD_H

#include <vector>
#include <set>
#include "../abstract_task.h"

namespace novelty {
class NoveltyRecord {
    const std::shared_ptr<AbstractTask> task;
    int level;
    std::vector<std::set<std::vector<FactPair>>> reached_facts;
public:
    NoveltyRecord(const std::shared_ptr<AbstractTask>& task, int level = 1);
    virtual ~NoveltyRecord() = default;
    
    virtual void clear();
    virtual int get_value(const std::vector<int>& state_values, uint h = 0);

    virtual int get_num_reached_facts(int h) {return reached_facts[h].size();}
    virtual int get_num_reached_facts() {
        int size = 0;
        for (std::set<std::vector<FactPair>>& facts : reached_facts)
            size += facts.size();
        return size;
    }

    int get_level() {return level;}

};
}

#endif