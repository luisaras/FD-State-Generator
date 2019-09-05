PDDL="../pyperplan/benchmarks/sokoban"

# Generate output.sas
./fast-downward.py --translate --sas-file "output.sas" ${PDDL}/domain.pddl ${PDDL}/task03.pddl --translate-options --tnf

# Generate new_output.sas
./fast-downward.py output.sas --internal-plan-file "new_output.sas" --search "generator(lmcut(), max_it = 1000000)"

# Find plan for new_output.sas
./fast-downward.py new_output.sas --search "astar(lmcut())"