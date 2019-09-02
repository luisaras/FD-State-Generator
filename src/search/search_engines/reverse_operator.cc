#include "reverse_operator.h"

using namespace std;

namespace reverse_search {

ReverseOperator::ReverseOperator(const vector<FactPair> &prev_pairs,
                                   const vector<FactPair> &pre_pairs,
                                   const vector<FactPair> &eff_pairs,
                                   int cost)
    : cost(cost),
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

/*
  Recursive method; called by build_abstract_operators. In the case
  of a precondition with value = -1 in the concrete operator, all
  multiplied out abstract operators are computed, i.e. for all
  possible values of the variable (with precondition = -1), one
  abstract operator with a concrete value (!= -1) is computed.
*/
void multiply_out(
    int pos, int cost, vector<FactPair> &prev_pairs,
    vector<FactPair> &pre_pairs,
    vector<FactPair> &eff_pairs,
    const vector<FactPair> &effects_without_pre,
    const VariablesProxy &variables,
    vector<ReverseOperator> &operators) {
    if (pos == static_cast<int>(effects_without_pre.size())) {
        // All effects without precondition have been checked: insert op.
        if (!eff_pairs.empty()) {
            operators.push_back(
                ReverseOperator(prev_pairs, pre_pairs, eff_pairs, cost));
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
            multiply_out(pos + 1, cost, prev_pairs, pre_pairs, eff_pairs,
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
    const OperatorProxy &op, int cost,
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
    multiply_out(0, cost, prev_pairs, pre_pairs, eff_pairs, effects_without_pre,
                 variables, operators);
}

}