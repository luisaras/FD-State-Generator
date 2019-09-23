#include "match_tree.h"

#include <cassert>
#include <iostream>
#include <utility>

using namespace std;

namespace reverse_search {

struct MatchTree::Node {
    static const int LEAF_NODE = -1;
    Node();
    ~Node();
    vector<int> applicable_operator_ids;
    // The variable which this node represents.
    int var_id;
    int var_domain_size;
    /*
      Each node has one outgoing edge for each possible value of the variable
      and one "star-edge" that is used when the value of the variable is
      undefined.
    */
    Node **successors;
    Node *star_successor;

    void initialize(int var_id, int var_domain_size);
    bool is_leaf_node() const;
};

MatchTree::Node::Node()
    : var_id(LEAF_NODE),
      var_domain_size(0),
      successors(nullptr),
      star_successor(nullptr) {
}

MatchTree::Node::~Node() {
    if (successors) {
        for (int i = 0; i < var_domain_size; ++i) {
            delete successors[i];
        }
        delete[] successors;
    }
    delete star_successor;
}

void MatchTree::Node::initialize(int var_id_, int var_domain_size_) {
    assert(is_leaf_node());
    assert(var_id_ >= 0);
    var_id = var_id_;
    var_domain_size = var_domain_size_;
    if (var_domain_size > 0) {
        successors = new Node *[var_domain_size];
        for (int val = 0; val < var_domain_size; ++val) {
            successors[val] = nullptr;
        }
    }
}

bool MatchTree::Node::is_leaf_node() const {
    return var_id == LEAF_NODE;
}

MatchTree::MatchTree(const TaskProxy &task_proxy)
    : task_proxy(task_proxy),
      root(nullptr) {
}

MatchTree::~MatchTree() {
    delete root;
}

void MatchTree::insert_recursive(
    int op_id, const vector<FactPair> &regression_preconditions,
    int pre_index, Node **edge_from_parent) {
    if (*edge_from_parent == 0) {
        // We don't exist yet: create a new node.
        *edge_from_parent = new Node();
    }

    Node *node = *edge_from_parent;
    if (pre_index == static_cast<int>(regression_preconditions.size())) {
        // All preconditions have been checked, insert operator ID.
        node->applicable_operator_ids.push_back(op_id);
    } else {
        const FactPair &fact = regression_preconditions[pre_index];
        
        VariableProxy var = task_proxy.get_variables()[fact.var];
        int var_domain_size = var.get_domain_size();

        // Set up node correctly or insert a new node if necessary.
        if (node->is_leaf_node()) {
            node->initialize(fact.var, var_domain_size);
        } else if (node->var_id > fact.var) {
            /* The variable to test has been left out: must insert new
               node and treat it as the "node". */
            Node *new_node = new Node();
            new_node->initialize(fact.var, var_domain_size);
            // The new node gets the left out variable as its variable.
            *edge_from_parent = new_node;
            new_node->star_successor = node;
            // The new node is now the node of interest.
            node = new_node;
        }

        /* Set up edge to the correct child (for which we want to call
           this function recursively). */
        Node **edge_to_child = 0;
        if (node->var_id == fact.var) {
            // Operator has a precondition on the variable tested by node.
            edge_to_child = &node->successors[fact.value];
            ++pre_index;
        } else {
            // Operator doesn't have a precondition on the variable tested by
            // node: follow/create the star-edge.
            assert(node->var_id < fact.var);
            edge_to_child = &node->star_successor;
        }

        insert_recursive(op_id, regression_preconditions, pre_index, edge_to_child);
    }
}

void MatchTree::insert(int op_id, const vector<FactPair> &regression_preconditions) {
    // Regression preconditions are the effects of the original operator
    insert_recursive(op_id, regression_preconditions, 0, &root);
}

void MatchTree::get_applicable_operator_ids_recursive(
    Node *node, const vector<int> &state, set<int> &operator_ids) const {
    /*
      Note: different from the code that builds the match tree, we do
      the test if node == 0 *before* calling traverse rather than *at
      the start* of traverse since this turned out to be faster in
      some informal experiments.
     */

    for (int id : node->applicable_operator_ids)
        operator_ids.insert(id);

    if (node->is_leaf_node())
        return;

    int val = state[node->var_id];

    if (val >= node->var_domain_size or val < 0) {
        // Undefined, could be any value
        for (int val = 0; val < node->var_domain_size; ++val) {
            if (!node->successors[val])
                continue;
            get_applicable_operator_ids_recursive(
                node->successors[val], state, operator_ids);
        }
    } else if (node->successors[val]) {
        // Follow the correct successor edge, if it exists.
        get_applicable_operator_ids_recursive(
            node->successors[val], state, operator_ids);
    }
    if (node->star_successor) {
        // Always follow the star edge, if it exists.
        get_applicable_operator_ids_recursive(
            node->star_successor, state, operator_ids);
    }
}

void MatchTree::get_applicable_operator_ids(
    const vector<int> &state, set<int> &operator_ids) const {
    if (root)
        get_applicable_operator_ids_recursive(root, state, operator_ids);
}

void MatchTree::dump_recursive(Node *node) const {
    if (!node) {
        // Node is the root node.
        cout << "Empty MatchTree" << endl;
        return;
    }
    cout << endl;
    cout << "node->var_id = " << node->var_id << endl;
    cout << "Number of applicable operators at this node: "
         << node->applicable_operator_ids.size() << endl;
    for (int op_id : node->applicable_operator_ids) {
        cout << "AbstractOperator #" << op_id << endl;
    }
    if (node->is_leaf_node()) {
        cout << "leaf node." << endl;
        assert(!node->successors);
        assert(!node->star_successor);
    } else {
        for (int val = 0; val < node->var_domain_size; ++val) {
            if (node->successors[val]) {
                cout << "recursive call for child with value " << val << endl;
                dump_recursive(node->successors[val]);
                cout << "back from recursive call (for successors[" << val
                     << "]) to node with var_id = " << node->var_id
                     << endl;
            } else {
                cout << "no child for value " << val << endl;
            }
        }
        if (node->star_successor) {
            cout << "recursive call for star_successor" << endl;
            dump_recursive(node->star_successor);
            cout << "back from recursive call (for star_successor) "
                 << "to node with var_id = " << node->var_id << endl;
        } else {
            cout << "no star_successor" << endl;
        }
    }
}

void MatchTree::dump() const {
    dump_recursive(root);
}

}
