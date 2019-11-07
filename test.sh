DOMAIN="../pyperplan/benchmarks/sokoban/domain.pddl"
TASK="../pyperplan/benchmarks/sokoban/task01.pddl"

test_novelty() {
    # Generate output.sas
    ./fast-downward.py --debug --translate --sas-file output.sas ${DOMAIN} ${TASK}
    # Find plan for new_output.sas
    ./fast-downward.py --debug output.sas --search "novelty_search(level=2, prune=true)"
    #./fast-downward.py --debug output.sas --search "astar(lmcut())"

    #./fast-downward.py --debug "../pyperplan/benchmarks/blocks/domain.pddl" "../pyperplan/benchmarks/blocks/task01.pddl" --search "novelty_search(level=2, prune=true)"
}

test_hillclimbing() {
    ./fast-downward.py --debug --translate --sas-file output.sas ${DOMAIN} ${TASK}
    ./fast-downward.py --debug output.sas --search "ehc(cpdbs(systematic(5)))"
}

test_abstract() {
    # Generate output.sas
    ./fast-downward.py --debug --translate --sas-file output.sas ${DOMAIN} ${TASK}
    # Generate new_output.sas
    ./fast-downward.py --debug output.sas --internal-plan-file new_output.sas --search "generator_abstract([$1], max_it = 1000000)"
    # Find plan for new_output.sas
    ./fast-downward.py --debug new_output.sas --search "astar(lmcut())"
}

test_complexity() {
    #test_abstract "lmcut(), complexity(novelty_search(level=3, reverse=true, undef_value=true, verbosity=SILENT), bound=false)"
    #test_abstract "complexity(ehc(cpdbs(systematic(2)), undef_value=true, verbosity=SILENT)), complexity(ehc(cpdbs(systematic(3)), undef_value=true, verbosity=SILENT))"
    test_abstract "complexity(astar(lmcut(), undef_value=true, verbosity=SILENT)), lmcut()"
}

test_complexity

#src/sas_to_pddl.py ../pyperplan/benchmarks/blocks/task01.pddl generator-tests/ipdb/blocks/01_task.sas new_task.pddl