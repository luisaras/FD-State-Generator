PDDL="../pyperplan/benchmarks/sokoban"

IPDB="ipdb(min_improvement=100, collection_max_size=200000)"
CPDB="cpdbs(patterns=systematic(4))"
PDB="cpdbs(patterns=manual([[19], [20], [16, 20], [14, 16, 20], [10, 14, 16, 20], [10, 14, 16, 19, 20], [10, 14, 16, 18, 20], [10, 14, 15, 16, 18, 20], [10, 14, 15, 16, 18, 19, 20], [10, 11, 14, 15, 16, 18, 19, 20]]))"

test_tnf_planner() {
    # Generate output.sas
    ./fast-downward.py --debug --translate --sas-file "output.sas" ${PDDL}/domain.pddl ${PDDL}/task$1.pddl
    # Find plan for output.sas
    ./fast-downward.py --debug "output.sas" --search "astar($IPDB)"
    # Generate output.sas
    ./fast-downward.py --debug --translate --sas-file "output.sas" ${PDDL}/domain.pddl ${PDDL}/task$1.pddl --translate-options --tnf
    # Find plan for output.sas
    ./fast-downward.py --debug "output.sas" --search "astar($IPDB)"
}

# [[19], [20], [16, 20], [14, 16, 20], [10, 14, 16, 20], [10, 14, 16, 19, 20], [10, 14, 16, 18, 20], [10, 14, 15, 16, 18, 20], [10, 14, 15, 16, 18, 19, 20], [10, 11, 14, 15, 16, 18, 19, 20]]
# [[0], [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [16, 20], [14, 16, 20], [3, 14, 16, 20], [3, 10, 14, 16, 20], [3, 10, 14, 15, 16, 20], [3, 10, 14, 16, 18, 20], [0, 3, 10, 14, 16, 18, 20]]

test_tnf() {
    # Generate output.sas
    ./fast-downward.py --debug --translate --sas-file "output.sas" ${PDDL}/domain.pddl ${PDDL}/task$1.pddl --translate-options --tnf
    # Generate new_output.sas
    ./fast-downward.py --debug output.sas --internal-plan-file "new_output.sas" --search "generator_tnf(lmcut(), max_it = 1000000)"
    # Find plan for new_output.sas
    ./fast-downward.py --debug "new_output.sas" --search "astar(lmcut())"
}

test_random() {
    # Generate output.sas
    ./fast-downward.py --debug --translate --sas-file "output.sas" ${PDDL}/domain.pddl ${PDDL}/task$1.pddl
    # Generate new_output.sas
    ./fast-downward.py --debug output.sas --internal-plan-file "new_output.sas" --search "generator_random(lmcut(), max_it = 1000000)"
    # Find plan for new_output.sas
    ./fast-downward.py --debug "new_output.sas" --search "astar(lmcut())"
}

test_abstract() {
    # Generate output.sas
    ./fast-downward.py --debug --translate --sas-file "output.sas" ${PDDL}/domain.pddl ${PDDL}/task$1.pddl
    # Generate new_output.sas
    ./fast-downward.py --debug output.sas --internal-plan-file "new_output.sas" --search "generator_abstract(abstract(lmcut()), max_it = 1000000)"
    # Find plan for new_output.sas
    ./fast-downward.py --debug "new_output.sas" --search "astar(lmcut())"
}

test_tnf_planner 03