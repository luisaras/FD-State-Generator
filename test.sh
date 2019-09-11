PDDL="../pyperplan/benchmarks/sokoban"

# Generate output.sas
./fast-downward.py --debug --translate --sas-file "output.sas" ${PDDL}/domain.pddl ${PDDL}/task01.pddl #--translate-options --tnf

# Generate new_output.sas
./fast-downward.py --debug output.sas --internal-plan-file "new_output.sas" --search "generator(lmcut(), max_it = 1000000)"

# Find plan for new_output.sas
#./fast-downward.py --debug new_output.sas --search "astar(lmcut())"