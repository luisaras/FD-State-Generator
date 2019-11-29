#DOMAIN="../pyperplan/benchmarks/openstacks/domain04.pddl"
#TASK="../pyperplan/benchmarks/openstacks/task04.pddl"

FOLDER=../

ALLDOMAINS=(barman elevator floor-tile no-mystery openstacks parc-printer parking peg-solitaire scanalyzer-3d sokoban storage tidybot transport visit-all woodworking)

rm fulldbs.txt

for p in "${ALLDOMAINS[@]}"; do
    for i in $(seq 1 20); do
        # Get input files
        PDDL_DIR=../pddl-instances/ipc-2011/domains/$p-sequential-optimal
        # Input files
        DOMAIN_INPUT=${PDDL_DIR}/domain.pddl
        if [ ! -f ${DOMAIN_INPUT} ]; then
            DOMAIN_INPUT=${PDDL_DIR}/domains/domain-$i.pddl
        fi
        TASK_INPUT=${PDDL_DIR}/instances/instance-$i.pddl

        OUTPUT=$(
            ulimit -v 2000000
            ulimit -t 300000
            ./fast-downward.py --debug --translate --sas-file output.sas ${DOMAIN_INPUT} ${TASK_INPUT}
            ./fast-downward.py --debug output.sas --search "eager_greedy([pdb(greedy(max_states=infinity))])"
        )
        echo $p$i $(echo "${OUTPUT}" | grep "Solution found!") >> fulldbs.txt
    done
done