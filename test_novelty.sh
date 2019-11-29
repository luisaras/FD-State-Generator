#DOMAIN="../pyperplan/benchmarks/openstacks/domain04.pddl"
#TASK="../pyperplan/benchmarks/openstacks/task04.pddl"

for p in blocks sokoban openstacks; do
    for i in $(seq -w 1 10); do
        # Get input files
        PDDL_DIR=../pyperplan/benchmarks/$p
        DOMAIN_INPUT=${PDDL_DIR}/domain$i.pddl
        if [ ! -f ${DOMAIN_INPUT} ]; then
            DOMAIN_INPUT=${PDDL_DIR}/domain.pddl
        fi
        TASK_INPUT=${PDDL_DIR}/task$i.pddl

        OUTPUT_0=$(
            ./fast-downward.py --debug --translate --sas-file output.sas ${DOMAIN_INPUT} ${TASK_INPUT}
            ./fast-downward.py --debug output.sas --search "novelty_search(level=2,prune=true,eval=lmcut(),goal=0)"
        )

        GOAL_COUNT=$(echo "${OUTPUT_0}" | grep "Number of goals" | tr -d "Number of goals: ")
        
        echo $p$i goal 0 $(echo "${OUTPUT_0}" | grep "Solution found!")

        GOAL_COUNT="$((${GOAL_COUNT}-1))"
        for g in $(seq 1 ${GOAL_COUNT}); do
            OUTPUT=$(
                ./fast-downward.py --debug --translate --sas-file output.sas ${DOMAIN_INPUT} ${TASK_INPUT}
                ./fast-downward.py --debug output.sas --search "novelty_search(level=2,prune=true,eval=lmcut(),goal=$g)"
            )
            echo $p$i goal $g $(echo "${OUTPUT}" | grep "Solution found!")
        done
    done
done