PLANNER="astar(lmcut(),max_time=300000)" # Five minutes
# Temp files
TRANSLATOR_TEMP=output.sas
PLANNER_TEMP=sas_plan

generate()  {
    # Parameters
    TASK=$1 # Problem name
    FOLDER=generator-tests/$2 # Test folder where the output files will be written
    GENERATOR=gen-$2 # Generator alias

    # Create folders
    if [ ! -d $FOLDER ]; then
        mkdir $FOLDER
    fi
    if [ ! -d $FOLDER/$TASK ]; then
        mkdir $FOLDER/$TASK
    fi

    # Output directory 
    OUTPUT_DIR=$FOLDER/$TASK

    # Input directory
    PDDL_DIR=../pyperplan/benchmarks/$TASK

    for i in $(seq -w 1 10); do

        # Input files
        DOMAIN_INPUT=${PDDL_DIR}/domain$i.pddl
        if [ ! -f ${DOMAIN_INPUT} ]; then
            DOMAIN_INPUT=${PDDL_DIR}/domain.pddl
        fi
        TASK_INPUT=${PDDL_DIR}/task$i.pddl

        # Generate output.sas
        ./fast-downward.py --translate --sas-file $TRANSLATOR_TEMP $DOMAIN_INPUT $TASK_INPUT #--translate-options --tnf

        # Generator output files
        NEW_TASK=${OUTPUT_DIR}/${i}_task.sas
        NEW_TASK_PDDL=${OUTPUT_DIR}/${i}_task.pddl
        GEN_OUTPUT=${OUTPUT_DIR}/${i}_gen.txt

        echo $GENERATOR $TASK$i

        # Generate $i_task.sas
        ./fast-downward.py --alias $GENERATOR $TRANSLATOR_TEMP > $GEN_OUTPUT
        cat $PLANNER_TEMP > $NEW_TASK

        # Generate PDDL file for new task
        src/sas_to_pddl.py $TASK_INPUT $NEW_TASK $NEW_TASK_PDDL

        # Planner output files
        PLAN_OUTPUT=${OUTPUT_DIR}/${i}_plan.txt

        # Find plan for $i_task.sas
        ./fast-downward.py $NEW_TASK --internal-plan-file $PLANNER_TEMP --search "$PLANNER" > $PLAN_OUTPUT

    done

    # Delete temp files
    rm ${TRANSLATOR_TEMP}
    rm ${PLANNER_TEMP}

}

plan() {
    # Parameters
    TASK=$1 # Problem name
    FOLDER=generator-tests/$2 # Test folder where the output files will be written
    SEARCH=$3 # Heuristic method to guide generation

    # Create folders
    if [ ! -d ${FOLDER} ]; then
        mkdir ${FOLDER}
    fi
    if [ ! -d ${FOLDER}/${TASK} ]; then
        mkdir ${FOLDER}/${TASK}
    fi

    # Output directory 
    OUTPUT_DIR=${FOLDER}/${TASK}

    # Input directory
    PDDL_DIR=../pyperplan/benchmarks/${TASK}

    for i in $(seq -w 1 10); do

        # Input files
        DOMAIN_INPUT=${PDDL_DIR}/domain$i.pddl
        if [ ! -f ${DOMAIN_INPUT} ]; then
            DOMAIN_INPUT=${PDDL_DIR}/domain.pddl
        fi
        TASK_INPUT=${PDDL_DIR}/task$i.pddl

        # Generate output.sas
        ./fast-downward.py --translate --sas-file ${TRANSLATOR_TEMP} ${DOMAIN_INPUT} ${TASK_INPUT} #--translate-options --tnf

        # Generator output files
        PLAN_OUTPUT=${OUTPUT_DIR}/${i}_plan.txt

        # Generate $i_task.sas
        ./fast-downward.py ${TRANSLATOR_TEMP} --internal-plan-file ${PLANNER_TEMP} --search "${SEARCH}" > ${PLAN_OUTPUT}

    done

    # Delete temp files
    rm ${TRANSLATOR_TEMP}
    rm ${PLANNER_TEMP}

}

ALLDOMAINS=(blocks sokoban airport)
ALLH=(lmcut ipdb astar)
#      <h> <w(h),h>   <c,h>        <w(h),c,h>           <c,w(h),h>
ALLGEN=("" "novelty-" "conflicts-" "novelty-conflicts-" "conflicts-novelty-")

for p in "${ALLDOMAINS[@]}"; do
    plan $p planner $PLANNER
    for h in "${ALLH[@]}"; do
        for g in "${ALLGEN[@]}"; do
            generate $p $g$h 
        done
    done
done

# Delete temp files
rm ${TRANSLATOR_TEMP}
rm ${PLANNER_TEMP}