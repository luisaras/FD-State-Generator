task() 
{
    TASK=$1
    OUTPUT_DIR=generator-tests/${TASK}
    PDDL="../pyperplan/benchmarks/$1"
    for i in $(seq -w 1 10); do
        NEW_TASK=${OUTPUT_DIR}/${i}_task.sas
        GEN_OUTPUT=${OUTPUT_DIR}/${i}_gen.txt
        PLAN_OUTPUT=${OUTPUT_DIR}/${i}_plan.txt
        # Generate output.sas
        ./fast-downward.py --translate --sas-file "output.sas" ${PDDL}/domain.pddl ${PDDL}/task$i.pddl --translate-options --tnf
        # Generate $i_task.sas
        ./fast-downward.py "output.sas" --internal-plan-file "${NEW_TASK}" --search "generator(lmcut(), max_it=1000000)" > ${GEN_OUTPUT}
        # Find plan for $i_task.sas
        ./fast-downward.py "${NEW_TASK}" --search "astar(lmcut())" > ${PLAN_OUTPUT}
    done
    rm output.sas
    rm sas_plan
}

task sokoban
task airport
task blocks