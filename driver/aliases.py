# -*- coding: utf-8 -*-
from __future__ import print_function

import os

from .util import DRIVER_DIR

PORTFOLIO_DIR = os.path.join(DRIVER_DIR, "portfolios")

ALIASES = {}

def add_gen_aliases(ALIASES):

  GENERATOR = "generator_abstract([%s],print_h=%s,max_time=%s)"
  H = "h"
  NOVELTY = "novelty_h(prune=false,eval=h,reverse=true,level=%s),h"
  CONFLICTS = "sum([weight(pho2,-1),pho3]),h"
  NOVELTY_CONFLICTS = "novelty_h(prune=false,eval=h,reverse=true,level=%s),sum([weight(pho2,-1),pho3]),h"
  CONFLICTS_NOVELTY = "sum([weight(pho2,-1),pho3]),novelty_h(prune=false,eval=h,reverse=true,level=%s),h"

  HEURISTICS = {}
  HEURISTICS["lmcut"] = "h=lmcut()"
  HEURISTICS["ipdb"] = "h=ipdb()"
  HEURISTICS["astar"] = "h=complexity(astar(lmcut(),undef_value=true,verbosity=SILENT))"
  HEURISTICS["fulldb"] = "h=pdb(greedy(max_states=infinity))"
  HEURISTICS["pho3"] = "pho3=operatorcounting([pho_constraints(systematic(3))])"
  HEURISTICS["pho2"] = "pho2=operatorcounting([pho_constraints(systematic(2))])"

  for h in ["lmcut", "ipdb", "fulldb", "astar"]:
    for t in [0, 1, 2]: 
      time = "infinity" if t == 0 else str(6900 - 3300 * t)
      l = "-" + str(t)
      ALIASES["gen-" + h + l] = [
        "--evaluator", HEURISTICS[h],
        "--search", GENERATOR % (H, 0, time)
      ]
      ALIASES["gen-novelty-" + h + l] = [
        "--evaluator",  HEURISTICS[h],
        "--search", GENERATOR % (NOVELTY % 1, 1, time)
      ]
      ALIASES["gen-novelty2-" + h + l] = [
        "--evaluator",  HEURISTICS[h],
        "--search", GENERATOR % (NOVELTY % 2, 1, time)
      ]
      ALIASES["gen-conflicts-" + h + l] = [
        "--evaluator", HEURISTICS[h],
        "--evaluator", HEURISTICS["pho2"],
        "--evaluator", HEURISTICS["pho3"],
        "--search", GENERATOR % (CONFLICTS, 1, time)
      ]
      ALIASES["gen-novelty-conflicts-" + h + l] = [
        "--evaluator", HEURISTICS[h],
        "--evaluator", HEURISTICS["pho2"],
        "--evaluator", HEURISTICS["pho3"],
        "--search", GENERATOR % (NOVELTY_CONFLICTS % 1, 2, time)
      ]
      ALIASES["gen-conflicts-novelty-" + h + l] = [
        "--evaluator", HEURISTICS[h],
        "--evaluator", HEURISTICS["pho2"],
        "--evaluator", HEURISTICS["pho3"],
        "--search", GENERATOR % (CONFLICTS_NOVELTY % 1, 2, time)
      ]
      ALIASES["gen-novelty2-conflicts-" + h + l] = [
        "--evaluator", HEURISTICS[h],
        "--evaluator", HEURISTICS["pho2"],
        "--evaluator", HEURISTICS["pho3"],
        "--search", GENERATOR % (NOVELTY_CONFLICTS % 2, 2, time)
      ]
      ALIASES["gen-conflicts-novelty2-" + h + l] = [
        "--evaluator", HEURISTICS[h],
        "--evaluator", HEURISTICS["pho2"],
        "--evaluator", HEURISTICS["pho3"],
        "--search", GENERATOR % (CONFLICTS_NOVELTY % 2, 2, time)
      ]


ALIASES["seq-sat-fd-autotune-1"] = [
    "--evaluator", "hff=ff(transform=adapt_costs(one))",
    "--evaluator", "hcea=cea()",
    "--evaluator", "hcg=cg(transform=adapt_costs(plusone))",
    "--evaluator", "hgc=goalcount()",
    "--evaluator", "hAdd=add()",
    "--search", """iterated([
lazy(alt([single(sum([g(),weight(hff,10)])),
          single(sum([g(),weight(hff,10)]),pref_only=true)],
         boost=2000),
     preferred=[hff],reopen_closed=false,cost_type=one),
lazy(alt([single(sum([g(),weight(hAdd,7)])),
          single(sum([g(),weight(hAdd,7)]),pref_only=true),
          single(sum([g(),weight(hcg,7)])),
          single(sum([g(),weight(hcg,7)]),pref_only=true),
          single(sum([g(),weight(hcea,7)])),
          single(sum([g(),weight(hcea,7)]),pref_only=true),
          single(sum([g(),weight(hgc,7)])),
          single(sum([g(),weight(hgc,7)]),pref_only=true)],
         boost=1000),
     preferred=[hcea,hgc],reopen_closed=false,cost_type=one),
lazy(alt([tiebreaking([sum([g(),weight(hAdd,3)]),hAdd]),
          tiebreaking([sum([g(),weight(hAdd,3)]),hAdd],pref_only=true),
          tiebreaking([sum([g(),weight(hcg,3)]),hcg]),
          tiebreaking([sum([g(),weight(hcg,3)]),hcg],pref_only=true),
          tiebreaking([sum([g(),weight(hcea,3)]),hcea]),
          tiebreaking([sum([g(),weight(hcea,3)]),hcea],pref_only=true),
          tiebreaking([sum([g(),weight(hgc,3)]),hgc]),
          tiebreaking([sum([g(),weight(hgc,3)]),hgc],pref_only=true)],
         boost=5000),
     preferred=[hcea,hgc],reopen_closed=false,cost_type=normal),
eager(alt([tiebreaking([sum([g(),weight(hAdd,10)]),hAdd]),
           tiebreaking([sum([g(),weight(hAdd,10)]),hAdd],pref_only=true),
           tiebreaking([sum([g(),weight(hcg,10)]),hcg]),
           tiebreaking([sum([g(),weight(hcg,10)]),hcg],pref_only=true),
           tiebreaking([sum([g(),weight(hcea,10)]),hcea]),
           tiebreaking([sum([g(),weight(hcea,10)]),hcea],pref_only=true),
           tiebreaking([sum([g(),weight(hgc,10)]),hgc]),
           tiebreaking([sum([g(),weight(hgc,10)]),hgc],pref_only=true)],
          boost=500),
      preferred=[hcea,hgc],reopen_closed=true,cost_type=normal)
],repeat_last=true,continue_on_fail=true)"""]

ALIASES["seq-sat-fd-autotune-2"] = [
    "--evaluator", "hcea=cea(transform=adapt_costs(plusone))",
    "--evaluator", "hcg=cg(transform=adapt_costs(one))",
    "--evaluator", "hgc=goalcount(transform=adapt_costs(plusone))",
    "--evaluator", "hff=ff()",
    "--search", """iterated([
ehc(hcea,preferred=[hcea],preferred_usage=0,cost_type=normal),
lazy(alt([single(sum([weight(g(),2),weight(hff,3)])),
          single(sum([weight(g(),2),weight(hff,3)]),pref_only=true),
          single(sum([weight(g(),2),weight(hcg,3)])),
          single(sum([weight(g(),2),weight(hcg,3)]),pref_only=true),
          single(sum([weight(g(),2),weight(hcea,3)])),
          single(sum([weight(g(),2),weight(hcea,3)]),pref_only=true),
          single(sum([weight(g(),2),weight(hgc,3)])),
          single(sum([weight(g(),2),weight(hgc,3)]),pref_only=true)],
         boost=200),
     preferred=[hcea,hgc],reopen_closed=false,cost_type=one),
lazy(alt([single(sum([g(),weight(hff,5)])),
          single(sum([g(),weight(hff,5)]),pref_only=true),
          single(sum([g(),weight(hcg,5)])),
          single(sum([g(),weight(hcg,5)]),pref_only=true),
          single(sum([g(),weight(hcea,5)])),
          single(sum([g(),weight(hcea,5)]),pref_only=true),
          single(sum([g(),weight(hgc,5)])),
          single(sum([g(),weight(hgc,5)]),pref_only=true)],
         boost=5000),
     preferred=[hcea,hgc],reopen_closed=true,cost_type=normal),
lazy(alt([single(sum([g(),weight(hff,2)])),
          single(sum([g(),weight(hff,2)]),pref_only=true),
          single(sum([g(),weight(hcg,2)])),
          single(sum([g(),weight(hcg,2)]),pref_only=true),
          single(sum([g(),weight(hcea,2)])),
          single(sum([g(),weight(hcea,2)]),pref_only=true),
          single(sum([g(),weight(hgc,2)])),
          single(sum([g(),weight(hgc,2)]),pref_only=true)],
         boost=1000),
     preferred=[hcea,hgc],reopen_closed=true,cost_type=one)
],repeat_last=true,continue_on_fail=true)"""]

add_gen_aliases(ALIASES)

def _get_lama(**kwargs):
    return [
        "--if-unit-cost",
        "--evaluator",
        "hlm=lmcount(lm_rhw(reasonable_orders=true),pref={pref})".format(**kwargs),
        "--evaluator", "hff=ff()",
        "--search", """iterated([
                         lazy_greedy([hff,hlm],preferred=[hff,hlm]),
                         lazy_wastar([hff,hlm],preferred=[hff,hlm],w=5),
                         lazy_wastar([hff,hlm],preferred=[hff,hlm],w=3),
                         lazy_wastar([hff,hlm],preferred=[hff,hlm],w=2),
                         lazy_wastar([hff,hlm],preferred=[hff,hlm],w=1)
                         ],repeat_last=true,continue_on_fail=true)""",
        "--if-non-unit-cost",
        "--evaluator",
        "hlm1=lmcount(lm_rhw(reasonable_orders=true),transform=adapt_costs(one),pref={pref})".format(**kwargs),
        "--evaluator", "hff1=ff(transform=adapt_costs(one))",
        "--evaluator",
        "hlm2=lmcount(lm_rhw(reasonable_orders=true),transform=adapt_costs(plusone),pref={pref})".format(**kwargs),
        "--evaluator", "hff2=ff(transform=adapt_costs(plusone))",
        "--search", """iterated([
                         lazy_greedy([hff1,hlm1],preferred=[hff1,hlm1],
                                     cost_type=one,reopen_closed=false),
                         lazy_greedy([hff2,hlm2],preferred=[hff2,hlm2],
                                     reopen_closed=false),
                         lazy_wastar([hff2,hlm2],preferred=[hff2,hlm2],w=5),
                         lazy_wastar([hff2,hlm2],preferred=[hff2,hlm2],w=3),
                         lazy_wastar([hff2,hlm2],preferred=[hff2,hlm2],w=2),
                         lazy_wastar([hff2,hlm2],preferred=[hff2,hlm2],w=1)
                         ],repeat_last=true,continue_on_fail=true)""",
        "--always"]
        # Append --always to be on the safe side if we want to append
        # additional options later.

ALIASES["seq-sat-lama-2011"] = _get_lama(pref="true")
ALIASES["lama"] = _get_lama(pref="false")

ALIASES["lama-first"] = [
    "--evaluator",
    "hlm=lmcount(lm_factory=lm_rhw(reasonable_orders=true),transform=adapt_costs(one),pref=false)",
    "--evaluator", "hff=ff(transform=adapt_costs(one))",
    "--search", """lazy_greedy([hff,hlm],preferred=[hff,hlm],
                               cost_type=one,reopen_closed=false)"""]

ALIASES["seq-opt-bjolp"] = [
    "--evaluator",
    "lmc=lmcount(lm_merged([lm_rhw(),lm_hm(m=1)]),admissible=true)",
    "--search",
    "astar(lmc,lazy_evaluator=lmc)"]

ALIASES["seq-opt-lmcut"] = [
    "--search", "astar(lmcut())"]


PORTFOLIOS = {}
for portfolio in os.listdir(PORTFOLIO_DIR):
    name, ext = os.path.splitext(portfolio)
    assert ext == ".py", portfolio
    PORTFOLIOS[name.replace("_", "-")] = os.path.join(PORTFOLIO_DIR, portfolio)


def show_aliases():
    for alias in sorted(ALIASES.keys() + PORTFOLIOS.keys()):
        print(alias)


def set_options_for_alias(alias_name, args):
    """
    If alias_name is an alias for a configuration, set args.search_options
    to the corresponding command-line arguments. If it is an alias for a
    portfolio, set args.portfolio to the path to the portfolio file.
    Otherwise raise KeyError.
    """
    assert not args.search_options
    assert not args.portfolio

    if alias_name in ALIASES:
        args.search_options = [x.replace(" ", "").replace("\n", "")
                               for x in ALIASES[alias_name]]
    elif alias_name in PORTFOLIOS:
        args.portfolio = PORTFOLIOS[alias_name]
    else:
        raise KeyError(alias_name)
