#include "reverse_operator.h"

using namespace std;

namespace reverse_search {

ReverseOperator::ReverseOperator(const OperatorProxy& op,
                                const vector<FactPair> &prev_pairs,
                                const vector<FactPair> &pre_pairs,
                                const vector<FactPair> &eff_pairs) :
        original_id(op.get_id()),
        cost(op.get_cost()),
        regression_preconditions(prev_pairs),
        regression_effects(pre_pairs) {
    
    regression_preconditions.insert(regression_preconditions.end(),
                                    eff_pairs.begin(),
                                    eff_pairs.end());
    // Sort preconditions for MatchTree construction.
    sort(regression_preconditions.begin(), regression_preconditions.end());
    for (size_t i = 1; i < regression_preconditions.size(); ++i) {
        assert(regression_preconditions[i].var !=
               regression_preconditions[i - 1].var);
    }
}

void ReverseOperator::apply(vector<int>& state) {
    for (const FactPair& precond : regression_preconditions)
        state[precond.var] = precond.value;
    for (const FactPair& effect : regression_effects)
        state[effect.var] = effect.value;
}

bool ReverseOperator::is_applicable(VariablesProxy &variables, vector<int>& state) {
    for (const FactPair& precond : regression_preconditions) {
        VariableProxy variable = variables[precond.var];
        if (state[precond.var] >= variable.get_domain_size())
            continue;
        if (state[precond.var] != precond.value)
            return false;
    }
    return true;
}

bool ReverseOperator::is_result(vector<int>& pred_state, vector<int>& state) {
    vector<bool> mentioned(pred_state.size(), false);
    for (const FactPair& effect : regression_effects) {
        if (pred_state[effect.var] != effect.value) {
            cout << "Effect not applied" << endl;
            return false;
        }
        mentioned[effect.var] = true;
    }
    for (uint i = 0; i < pred_state.size(); i++) {
        if (!mentioned[i] && pred_state[i] != state[i]) {
            cout << "Value not inherited." << endl;
            return false;
        }
    }
    return true;
}

void ReverseOperator::dump() {
    // Print preconditions of original operator
    cout << original_id << ") ";
    for (const FactPair& effect : regression_effects)
        cout << effect << " ";
    cout << " | ";
    // Print effects of original operator
    for (const FactPair& precond : regression_preconditions)
        cout << precond << " ";
    cout << endl;
}

/*
  Recursive method; called by build_abstract_operators. In the case
  of a precondition with value = -1 in the concrete operator, all
  multiplied out abstract operators are computed, i.e. for all
  possible values of the variable (with precondition = -1), one
  abstract operator with a concrete value (!= -1) is computed.
*/
void multiply_out(int pos,
    const OperatorProxy &op, 
    vector<FactPair> &prev_pairs,
    vector<FactPair> &pre_pairs,
    vector<FactPair> &eff_pairs,
    const vector<FactPair> &effects_without_pre,
    const VariablesProxy &variables,
    vector<ReverseOperator> &operators) {
    if (pos == static_cast<int>(effects_without_pre.size())) {
        // All effects without precondition have been checked: insert op.
        if (!eff_pairs.empty()) {
            operators.push_back(
                ReverseOperator(op, prev_pairs, pre_pairs, eff_pairs));
        }
    } else {
        // For each possible value for the current variable, build an
        // abstract operator.
        int var_id = effects_without_pre[pos].var;
        int eff = effects_without_pre[pos].value;
        VariableProxy var = variables[var_id];
        for (int i = 0; i < var.get_domain_size(); ++i) {
            if (i != eff) {
                pre_pairs.emplace_back(var_id, i);
                eff_pairs.emplace_back(var_id, eff);
            } else {
                prev_pairs.emplace_back(var_id, i);
            }
            multiply_out(pos + 1, op, prev_pairs, pre_pairs, eff_pairs,
                         effects_without_pre, variables, operators);
            if (i != eff) {
                pre_pairs.pop_back();
                eff_pairs.pop_back();
            } else {
                prev_pairs.pop_back();
            }
        }
    }
}

void build_reverse_operators(
    const OperatorProxy &op,
    const VariablesProxy &variables,
    std::vector<ReverseOperator> &operators) {
    // All variable value pairs that are a prevail condition
    vector<FactPair> prev_pairs;
    // All variable value pairs that are a precondition (value != -1)
    vector<FactPair> pre_pairs;
    // All variable value pairs that are an effect
    vector<FactPair> eff_pairs;
    // All variable value pairs that are a precondition (value = -1)
    vector<FactPair> effects_without_pre;

    size_t num_vars = variables.size();
    vector<bool> has_precond_and_effect_on_var(num_vars, false);
    vector<bool> has_precondition_on_var(num_vars, false);

    for (FactProxy pre : op.get_preconditions())
        has_precondition_on_var[pre.get_variable().get_id()] = true;

    for (EffectProxy eff : op.get_effects()) {
        int var_id = eff.get_fact().get_variable().get_id();
        
        int val = eff.get_fact().get_value();
        
        if (var_id != -1) {
            if (has_precondition_on_var[var_id]) {
                has_precond_and_effect_on_var[var_id] = true;
                eff_pairs.emplace_back(var_id, val);
            } else {
                effects_without_pre.emplace_back(var_id, val);
            }
        }
    }
    for (FactProxy pre : op.get_preconditions()) {
        int var_id = pre.get_variable().get_id();
        int val = pre.get_value();
        if (has_precond_and_effect_on_var[var_id]) {
            pre_pairs.emplace_back(var_id, val);
        } else {
            prev_pairs.emplace_back(var_id, val);
        }
    }
    multiply_out(0, op, prev_pairs, pre_pairs, eff_pairs, effects_without_pre,
                 variables, operators);
}

}