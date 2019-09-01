#ifndef SEARCH_MATCH_TREE_H
#define SEARCH_MATCH_TREE_H

#include "../task_proxy.h"

#include <cstddef>
#include <vector>
#include <set>

namespace reverse_search {

class MatchTree {
    TaskProxy task_proxy;
    struct Node;
    Node *root;
    void insert_recursive(int op_id,
                          const std::vector<FactPair> &regression_preconditions,
                          int pre_index,
                          Node **edge_from_parent);
    void get_applicable_operator_ids_recursive(Node *node, const std::vector<int> &state, std::set<int> &operator_ids) const;
    void dump_recursive(Node *node) const;
public:
    // Initialize an empty match tree.
    MatchTree(const TaskProxy &task_proxy);
    ~MatchTree();
    /* Insert an abstract operator into the match tree, creating or
       enlarging it. */
    void insert(int op_id, const std::vector<FactPair> &regression_preconditions);

    /*
      Extracts all IDs of applicable abstract operators for the abstract state
      given by state_index (the index is converted back to variable/values
      pairs).
    */
    void get_applicable_operator_ids(const std::vector<int> &state, std::set<int> &operator_ids) const;
    void dump() const;
};

}

#endif
