#include "task_properties.h"

#include "../utils/memory.h"
#include "../utils/system.h"

#include <algorithm>
#include <iostream>
#include <limits>

using namespace std;
using utils::ExitCode;


namespace task_properties {
bool is_unit_cost(TaskProxy task) {
    for (OperatorProxy op : task.get_operators()) {
        if (op.get_cost() != 1)
            return false;
    }
    return true;
}

bool has_axioms(TaskProxy task) {
    return !task.get_axioms().empty();
}

void verify_no_axioms(TaskProxy task) {
    if (has_axioms(task)) {
        cerr << "This configuration does not support axioms!"
             << endl << "Terminating." << endl;
        utils::exit_with(ExitCode::SEARCH_UNSUPPORTED);
    }
}

static int get_first_conditional_effects_op_id(TaskProxy task) {
    for (OperatorProxy op : task.get_operators()) {
        for (EffectProxy effect : op.get_effects()) {
            if (!effect.get_conditions().empty())
                return op.get_id();
        }
    }
    return -1;
}

bool has_conditional_effects(TaskProxy task) {
    return get_first_conditional_effects_op_id(task) != -1;
}

void verify_no_conditional_effects(TaskProxy task) {
    int op_id = get_first_conditional_effects_op_id(task);
    if (op_id != -1) {
        OperatorProxy op = task.get_operators()[op_id];
        cerr << "This configuration does not support conditional effects "
             << "(operator " << op.get_name() << ")!" << endl
             << "Terminating." << endl;
        utils::exit_with(ExitCode::SEARCH_UNSUPPORTED);
    }
}

vector<int> get_operator_costs(const TaskProxy &task_proxy) {
    vector<int> costs;
    OperatorsProxy operators = task_proxy.get_operators();
    costs.reserve(operators.size());
    for (OperatorProxy op : operators)
        costs.push_back(op.get_cost());
    return costs;
}

double get_average_operator_cost(TaskProxy task_proxy) {
    double average_operator_cost = 0;
    for (OperatorProxy op : task_proxy.get_operators()) {
        average_operator_cost += op.get_cost();
    }
    average_operator_cost /= task_proxy.get_operators().size();
    return average_operator_cost;
}

int get_min_operator_cost(TaskProxy task_proxy) {
    int min_cost = numeric_limits<int>::max();
    for (OperatorProxy op : task_proxy.get_operators()) {
        min_cost = min(min_cost, op.get_cost());
    }
    return min_cost;
}

int get_num_facts(const TaskProxy &task_proxy) {
    int num_facts = 0;
    for (VariableProxy var : task_proxy.get_variables())
        num_facts += var.get_domain_size();
    return num_facts;
}

int get_num_total_effects(const TaskProxy &task_proxy) {
    int num_effects = 0;
    for (OperatorProxy op : task_proxy.get_operators())
        num_effects += op.get_effects().size();
    num_effects += task_proxy.get_axioms().size();
    return num_effects;
}

bool verify_tnf(const TaskProxy &task_proxy) {
    VariablesProxy variables = task_proxy.get_variables();
    GoalsProxy goals = task_proxy.get_goals();
    if (goals.size() < variables.size())
        return false;
    vector<bool> miss(variables.size(), true);
    // Check variables in goal
    for (uint i = 0; i < goals.size(); i++)
        miss[goals[i].get_pair().var] = false;
    for (uint i = 0; i < variables.size(); i++) {
        if (miss[i]) {
            cout << "Goal does not mention all variables." << endl;
            return false;
        }
    }
    // Check variables in operators
    OperatorsProxy operators = task_proxy.get_operators();
    for (uint i = 0; i < operators.size(); i++) {
        for (uint j = 0; j < variables.size(); j++)
            miss[j] = true;
        PreconditionsProxy pre_cond = operators[i].get_preconditions();
        for (uint j = 0; j < pre_cond.size(); j++)
            miss[pre_cond[j].get_pair().var] = false;
        EffectsProxy effects = operators[i].get_effects();
        for (uint j = 0; j < effects.size(); j++) {
            if (!effects[j].get_conditions().empty()) {
                cout << "Task have conditional effects." << endl;
                return false;
            }
            FactPair fact = effects[j].get_fact().get_pair();
            if (miss[fact.var]) {
                cout << "Effect variable " << fact.var 
                     << " not mentioned in preconditions of " << operators[i].get_name()
                     << endl;
                return false; 
            }
        }
    }
    return true;
}

void print_variable_statistics(const TaskProxy &task_proxy) {
    const int_packer::IntPacker &state_packer = g_state_packers[task_proxy];

    int num_facts = 0;
    VariablesProxy variables = task_proxy.get_variables();
    for (VariableProxy var : variables)
        num_facts += var.get_domain_size();

    cout << "Variables: " << variables.size() << endl;
    cout << "FactPairs: " << num_facts << endl;
    cout << "Bytes per state: "
         << state_packer.get_num_bins() * sizeof(int_packer::IntPacker::Bin)
         << endl;
}

void dump_pddl(const State &state) {
    for (FactProxy fact : state) {
        string fact_name = fact.get_name();
        if (fact_name != "<none of those>")
            cout << fact_name << endl;
    }
}

void dump_fdr(const State &state) {
    for (FactProxy fact : state) {
        VariableProxy var = fact.get_variable();
        cout << "  #" << var.get_id() << " [" << var.get_name() << "] -> "
             << fact.get_value() << endl;
    }
}

void dump_goals(const GoalsProxy &goals) {
    cout << "Goal conditions:" << endl;
    for (FactProxy goal : goals) {
        cout << "  " << goal.get_variable().get_name() << ": "
             << goal.get_value() << endl;
    }
}

void dump_task(const TaskProxy &task_proxy) {
    OperatorsProxy operators = task_proxy.get_operators();
    int min_action_cost = numeric_limits<int>::max();
    int max_action_cost = 0;
    for (OperatorProxy op : operators) {
        min_action_cost = min(min_action_cost, op.get_cost());
        max_action_cost = max(max_action_cost, op.get_cost());
    }
    cout << "Min action cost: " << min_action_cost << endl;
    cout << "Max action cost: " << max_action_cost << endl;

    VariablesProxy variables = task_proxy.get_variables();
    cout << "Variables (" << variables.size() << "):" << endl;
    for (VariableProxy var : variables) {
        cout << "  " << var.get_name()
             << " (range " << var.get_domain_size() << ")" << endl;
        for (int val = 0; val < var.get_domain_size(); ++val) {
            cout << "    " << val << ": " << var.get_fact(val).get_name() << endl;
        }
    }
    State initial_state = task_proxy.get_initial_state();
    cout << "Initial state (PDDL):" << endl;
    dump_pddl(initial_state);
    cout << "Initial state (FDR):" << endl;
    dump_fdr(initial_state);
    dump_goals(task_proxy.get_goals());
}

PerTaskInformation<int_packer::IntPacker> g_state_packers(
    [](const TaskProxy &task_proxy) {
        VariablesProxy variables = task_proxy.get_variables();
        vector<int> variable_ranges;
        variable_ranges.reserve(variables.size());
        for (VariableProxy var : variables) {
            variable_ranges.push_back(var.get_domain_size() + task_proxy.has_undef_value());
        }
        if (task_proxy.has_undef_value()) {
            for (FactProxy fact : task_proxy.get_goals()) {
                variable_ranges[fact.get_pair().var]--;
            }
        }
        return utils::make_unique_ptr<int_packer::IntPacker>(variable_ranges);
    }
    );
}
