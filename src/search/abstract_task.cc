#include "abstract_task.h"

#include "per_task_information.h"
#include "plugin.h"

#include <iostream>

using namespace std;

const FactPair FactPair::no_fact = FactPair(-1, -1);

ostream &operator<<(ostream &os, const FactPair &fact_pair) {
    os << fact_pair.var << "=" << fact_pair.value;
    return os;
}

ostream &operator<<(ostream &os, shared_ptr<AbstractTask> task) {
    bool use_metric = false; // ?
    
    os << "begin_version" << endl << tasks::PRE_FILE_VERSION << endl << "end_version" << endl;
    os << "begin_metric" << endl << use_metric << endl << "end_metric" << endl;
    
    // Variables
    int num_var = task->get_num_variables();
    os << num_var << endl;
    for (int i = 0; i < num_var; ++i) {
        int domain_size = task->get_variable_domain_size(i);
        os << "begin_variable" << endl;
        os << task->get_variable_name(i) << endl;
        os << task->get_variable_axiom_layer(i) << endl;
        os << domain_size << endl;
        for (int v = 0; v < domain_size; ++v) {
            FactPair fact(i, v);
            os << task->get_fact_name(fact) << endl;
        }
        os << "end_variable" << endl;
    }
    
    // Mutex groups
    int num_mutex = 0;
     for (int i = 0; i < num_var; ++i) {
        int domain_size = task->get_variable_domain_size(i);
        for (int v = 0; v < domain_size; ++v) {
            FactPair fact1(i, v);
            set<FactPair> mutex_facts = task->get_mutex_facts(fact1);
            num_mutex += mutex_facts.size();
        }
    }
    os << num_mutex << endl;
    for (int i = 0; i < num_var; ++i) {
        int domain_size = task->get_variable_domain_size(i);
        for (int v = 0; v < domain_size; ++v) {
            FactPair fact1(i, v);
            set<FactPair> mutex_facts = task->get_mutex_facts(fact1);
            for (const FactPair& fact2 : mutex_facts) {
                os << "begin_mutex_group" << endl;
                os << 2 << endl; // Number of facts
                os << i << " " << v << endl;
                os << fact2.var << " " << fact2.value << endl;
                os << "end_mutex_group" << endl;
            }
        }
    }
    
    // Initial state
    os << "begin_state" << endl;
    for (int v : task->get_initial_state_values())
        os << v << " ";
    os << endl << "end_state" << endl;
    
    // Goals
    os << "begin_goal" << endl;
    int num_goals = task->get_num_goals();
    os << num_goals << endl;
    for (int i = 0; i < num_goals; ++i) {
        FactPair goal = task->get_goal_fact(i);
        os << goal.var << " " << goal.value << endl;
    }
    os << "end_goal" << endl;
    
    // Operators
    int num_op = task->get_num_operators();
    os << num_op << endl;
    for (int i = 0; i < num_op; ++i) {
        os << "begin_operator" << endl;
        os << task->get_operator_name(i, false) << endl;
        // Conditions
        int num_precond = task->get_num_operator_preconditions(i, false);
        os << num_precond << endl;
        for (int p = 0; p < num_precond; ++p) {
            FactPair precond = task->get_operator_precondition(i, p, false);
            os << precond.var << " " << precond.value << endl;
        }
        // Effects
        int num_effects = task->get_num_operator_effects(i, false);
        os << num_effects << endl;
        for (int e = 0; e < num_effects; ++e) {
            // Effect conditions
            num_precond = task->get_num_operator_effect_conditions(i, e, false);
            os << num_precond << endl;
            for (int p = 0; p < num_precond; ++p) {
                FactPair precond = task->get_operator_effect_condition(i, e, p, false);
                os << precond.var << " " << precond.value << endl;
            }
            // Effect fact
            FactPair fact = task->get_operator_effect(i, e, false);
            os << fact.var << " -1 " << fact.value << endl;
        }
        // Cost
        os << task->get_operator_cost(i, false) << endl;
        os << "end_operator" << endl;
    }
    
    // Axioms
    int num_axioms = task->get_num_axioms();
    os << num_axioms << endl;
    for (int i = 0; i < num_axioms; ++i) {
        os << "begin_rule" << endl;
        // Effect conditions
        int num_precond = task->get_num_operator_effect_conditions(i, 0, true);
        os << num_precond << endl;
        for (int p = 0; p < num_precond; ++p) {
            FactPair precond = task->get_operator_effect_condition(i, 0, p, true);
            os << precond.var << " " << precond.value << endl;
        }
        // Effect fact
        FactPair fact = task->get_operator_effect(i, 0, true);
        os << fact.var << " -1 " << fact.value << endl;
        os << "end_rule" << endl;
    }
    
    return os;
}

static PluginTypePlugin<AbstractTask> _type_plugin(
    "AbstractTask",
    // TODO: Replace empty string by synopsis for the wiki page.
    "");
