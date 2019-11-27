#include "search_space.h"

#include "global_state.h"
#include "search_node_info.h"
#include "task_proxy.h"
#include "task_utils/task_properties.h"

#include <cassert>

using namespace std;

SearchNode::SearchNode(StateRegistry &state_registry,
                       StateID state_id,
                       SearchNodeInfo &info,
                       int cost)
    : state_registry(state_registry),
      state_id(state_id),
      info(info),
      cost(cost) {
    assert(state_id != StateID::no_state);
}

GlobalState SearchNode::get_state() {
    return state_registry.lookup_state(state_id);
}

bool SearchNode::is_open() const {
    return info.status == SearchNodeInfo::OPEN;
}

bool SearchNode::is_closed() const {
    return info.status == SearchNodeInfo::CLOSED;
}

bool SearchNode::is_dead_end() const {
    return info.status == SearchNodeInfo::DEAD_END;
}

bool SearchNode::is_new() const {
    return info.status == SearchNodeInfo::NEW;
}

int SearchNode::get_g() const {
    assert(info.g >= 0);
    return info.g;
}

int SearchNode::get_real_g() const {
    return info.real_g;
}

int SearchNode::get_cost() const {
    return cost;
}

bool SearchNode::is_solved() const {
    return cost >= 0;
}

void SearchNode::open_initial() {
    assert(info.status == SearchNodeInfo::NEW);
    info.status = SearchNodeInfo::OPEN;
    info.g = 0;
    info.real_g = 0;
    info.parent_state_id = StateID::no_state;
    info.creating_operator = OperatorID::no_operator;
}

void SearchNode::open(const SearchNode &parent_node,
                      const OperatorProxy &parent_op,
                      int adjusted_cost) {
    assert(info.status == SearchNodeInfo::NEW);
    info.status = SearchNodeInfo::OPEN;
    info.g = parent_node.info.g + adjusted_cost;
    info.real_g = parent_node.info.real_g + parent_op.get_cost();
    info.parent_state_id = parent_node.get_state_id();
    info.creating_operator = OperatorID(parent_op.get_id());
}

void SearchNode::reopen(const SearchNode &parent_node,
                        const OperatorProxy &parent_op,
                        int adjusted_cost) {
    assert(info.status == SearchNodeInfo::OPEN ||
           info.status == SearchNodeInfo::CLOSED);

    // The latter possibility is for inconsistent heuristics, which
    // may require reopening closed nodes.
    info.status = SearchNodeInfo::OPEN;
    info.g = parent_node.info.g + adjusted_cost;
    info.real_g = parent_node.info.real_g + parent_op.get_cost();
    info.parent_state_id = parent_node.get_state_id();
    info.creating_operator = OperatorID(parent_op.get_id());
}

// like reopen, except doesn't change status
void SearchNode::update_parent(const SearchNode &parent_node,
                               const OperatorProxy &parent_op,
                               int adjusted_cost) {
    assert(info.status == SearchNodeInfo::OPEN ||
           info.status == SearchNodeInfo::CLOSED);
    // The latter possibility is for inconsistent heuristics, which
    // may require reopening closed nodes.
    info.g = parent_node.info.g + adjusted_cost;
    info.real_g = parent_node.info.real_g + parent_op.get_cost();
    info.parent_state_id = parent_node.get_state_id();
    info.creating_operator = OperatorID(parent_op.get_id());
}

void SearchNode::close() {
    assert(info.status == SearchNodeInfo::OPEN);
    info.status = SearchNodeInfo::CLOSED;
}

void SearchNode::mark_as_dead_end() {
    info.status = SearchNodeInfo::DEAD_END;
}

void SearchNode::dump(const TaskProxy &task_proxy) {
    cout << state_id << ": ";
    get_state().dump_fdr();
    if (info.creating_operator != OperatorID::no_operator) {
        OperatorsProxy operators = task_proxy.get_operators();
        OperatorProxy op = operators[info.creating_operator.get_index()];
        cout << " created by " << op.get_name()
             << " from " << info.parent_state_id << endl;
    } else {
        cout << " no parent" << endl;
    }
}

SearchSpace::SearchSpace(StateRegistry &state_registry, bool store_path)
    : state_registry(state_registry),
    store_path(store_path) {
}

SearchNode SearchSpace::get_node(const GlobalState &state) {
    int cost = -1;
    if (store_path) {
        const PathNodeInfo &path_info = path_node_infos[state];
        cost = path_info.cost;
    }
    return SearchNode(state_registry, state.get_id(), search_node_infos[state], cost);
}

void SearchSpace::trace_path(const GlobalState &goal_state,
                             vector<OperatorID> &path) {
    assert(path.empty());
    // Construct path from found state to final state
    GlobalState current_state = goal_state;
    if (store_path) {
        for (;;) {
            const PathNodeInfo &info = path_node_infos[current_state];
            if (info.successor_operator == OperatorID::no_operator) {
                assert(info.child_state_id == StateID::no_state);
                break;
            }
            GlobalState child_state = state_registry.lookup_state(info.child_state_id);
            SearchNodeInfo &child_info = search_node_infos[child_state];
            child_info.creating_operator = info.successor_operator;
            child_info.parent_state_id = current_state.get_id();
            current_state = child_state;
        }
    }
    //assert(task_properties::is_goal_state(state_registry.get_task_proxy(), current_state));

    // Construct path from initial state to final state
    StateID child_state(StateID::no_state);
    OperatorID sucessor_op(-1);
    int cost = 0;
    OperatorsProxy operators = state_registry.get_task_proxy().get_operators();
    for (;;) {
        // Update path info
        if (store_path) {
            PathNodeInfo &path_info = path_node_infos[current_state];
            if (!path_info.is_solved()) {
                path_info.child_state_id = child_state;
                path_info.successor_operator = sucessor_op;
                path_info.cost = cost;
            } else {
                assert(path_info.cost == cost);
            }
        }
        // Reconstruct path
        const SearchNodeInfo &info = search_node_infos[current_state];
        if (info.creating_operator == OperatorID::no_operator) {
            assert(info.parent_state_id == StateID::no_state);
            break;
        }
        sucessor_op = info.creating_operator;
        child_state = current_state.get_id();
        current_state = state_registry.lookup_state(info.parent_state_id);
        path.push_back(sucessor_op);
        cost += operators[sucessor_op].get_cost();
    }
    reverse(path.begin(), path.end());

}

void SearchSpace::dump(const TaskProxy &task_proxy) const {
    OperatorsProxy operators = task_proxy.get_operators();
    for (StateID id : state_registry) {
        /* The body duplicates SearchNode::dump() but we cannot create
           a search node without discarding the const qualifier. */
        GlobalState state = state_registry.lookup_state(id);
        const SearchNodeInfo &node_info = search_node_infos[state];
        cout << id << ": ";
        state.dump_fdr();
        if (node_info.creating_operator != OperatorID::no_operator &&
            node_info.parent_state_id != StateID::no_state) {
            OperatorProxy op = operators[node_info.creating_operator.get_index()];
            cout << " created by " << op.get_name()
                 << " from " << node_info.parent_state_id << endl;
        } else {
            cout << "has no parent" << endl;
        }
    }
}

void SearchSpace::print_statistics() const {
    state_registry.print_statistics();
    int closed = 0;
    int open = 0;
    const segmented_vector::SegmentedVector<SearchNodeInfo> &v = search_node_infos[&state_registry];
    for (int i = v.size() - 1; i >= 0; i--) {
        const SearchNodeInfo &info = v[i];
        if (info.status == SearchNodeInfo::CLOSED)
            closed++;
        else if (info.status == SearchNodeInfo::OPEN)
            open++;
    }
    cout << "Open nodes: " << open << endl;
    cout << "Closed states: " << closed << endl;
}

void SearchSpace::clear() {
    search_node_infos.clear();
}