#ifndef SEARCH_REVERSE_OPERATOR_H
#define SEARCH_REVERSE_OPERATOR_H

#include "../task_proxy.h"

namespace reverse_search {

class ReverseOperator {
public:

    const int original_id;

    /*
      This class represents an abstract operator how it is needed for
      the regression search performed during the PDB-construction. As
      all abstract states are represented as a number, abstract
      operators don't have "usual" effects but "hash effects", i.e. the
      change (as number) the abstract operator implies on a given
      abstract state.
    */

    const int cost;

    /*
      Preconditions for the regression search, corresponds to normal
      effects and prevail of concrete operators.
    */
    std::vector<FactPair> regression_preconditions;

    /*
      Effect of the operator during regression search on a given
      abstract state number.
    */
    std::vector<FactPair> regression_effects;

    /*
      Abstract operators are built from concrete operators. The
      parameters follow the usual name convention of SAS+ operators,
      meaning prevail, preconditions and effects are all related to
      progression search.
    */
    ReverseOperator(const OperatorProxy& op,
                    const std::vector<FactPair> &prevail,
                    const std::vector<FactPair> &preconditions,
                    const std::vector<FactPair> &effects);
    ~ReverseOperator() = default;

    void apply(std::vector<int>& state);

};

/*
  Computes all abstract operators for a given concrete operator (by
  its global operator number). Initializes data structures for initial
  call to recursive method multiply_out. variable_to_index maps
  variables in the task to their index in the pattern or -1.
*/
void build_reverse_operators(
    const OperatorProxy &op,
    const VariablesProxy &variables,
    std::vector<ReverseOperator> &operators);

}

#endif