#ifndef SEARCH_SPACE_H
#define SEARCH_SPACE_H

#include "global_state.h"
#include "operator_cost.h"
#include "per_state_information.h"
#include "search_node_info.h"

#include <vector>

class GlobalState;
class OperatorProxy;
class TaskProxy;


class SearchNode {
    StateRegistry &state_registry;
    StateID state_id;
    SearchNodeInfo &info;
    int cost;
public:
    SearchNode(StateRegistry &state_registry,
               StateID state_id,
               SearchNodeInfo &info,
               int cost = -1);

    StateID get_state_id() const {
        return state_id;
    }
    GlobalState get_state();

    bool is_new() const;
    bool is_open() const;
    bool is_closed() const;
    bool is_dead_end() const;

    int get_g() const;
    int get_real_g() const;
    int get_cost() const;

    bool is_solved() const;

    void open_initial();
    void open(const SearchNode &parent_node,
              const OperatorProxy &parent_op,
              int adjusted_cost);
    void reopen(const SearchNode &parent_node,
                const OperatorProxy &parent_op,
                int adjusted_cost);
    void update_parent(const SearchNode &parent_node,
                       const OperatorProxy &parent_op,
                       int adjusted_cost);
    void close();
    void mark_as_dead_end();

    void dump(const TaskProxy &task_proxy);
};

struct PathNodeInfo {
    StateID child_state_id;
    OperatorID successor_operator;
    int cost;
    PathNodeInfo()
        : child_state_id(StateID::no_state),
          successor_operator(-1),
          cost(-1) {
    }
    bool is_solved() const {
        return cost >= 0;
    }
};

class SearchSpace {
    PerStateInformation<SearchNodeInfo> search_node_infos;

    PerStateInformation<PathNodeInfo> path_node_infos;

    StateRegistry &state_registry;

    bool store_path;
public:
    explicit SearchSpace(StateRegistry &state_registry, bool store_path = true);

    SearchNode get_node(const GlobalState &state);

    void trace_path(const GlobalState &goal_state,
                    std::vector<OperatorID> &path);

    void dump(const TaskProxy &task_proxy) const;
    void print_statistics() const;

    void clear();

};

#endif
