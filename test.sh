TASK="../pyperplan/benchmarks/sokoban"

# Generate output.sas and new_output.sas
./fast-downward.py --keep-sas-file ${TASK}/domain.pddl ${TASK}/task01.pddl --search "generator(evals = [lmcut(), g()])"

# Find plan for new_output.sas
./fast-downward.py new_output.sas --search "astar(lmcut())"