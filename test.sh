TASK="../pyperplan/benchmarks/sokoban"
./fast-downward.py --keep-sas-file ${TASK}/domain.pddl ${TASK}/task01.pddl --search "astar(lmcut())"