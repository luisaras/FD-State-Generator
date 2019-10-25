task() 
{
    # Parameters
    TASK=$1 # Problem name
    FOLDER=generator-tests/$2 # Test folder where the output files will be written
    HEURISTIC=$3 # Heuristic method to guide generation

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

    # Temp files
    TRANSLATOR_TEMP=output.sas
    PLANNER_TEMP=sas_plan

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
        NEW_TASK=${OUTPUT_DIR}/${i}_task.sas
        GEN_OUTPUT=${OUTPUT_DIR}/${i}_gen.txt

        # Generate $i_task.sas
        ./fast-downward.py ${TRANSLATOR_TEMP} --internal-plan-file ${NEW_TASK} --search "generator_abstract([${HEURISTIC}], max_it=10000000, max_time=600)" > ${GEN_OUTPUT}

        # Planner output files
        PLAN_OUTPUT=${OUTPUT_DIR}/${i}_plan.txt

        # Find plan for $i_task.sas
        ./fast-downward.py ${NEW_TASK} --internal-plan-file ${PLANNER_TEMP} --search "astar(lmcut())" > ${PLAN_OUTPUT}

    done

    # Delete temp files
    rm ${TRANSLATOR_TEMP}
    rm ${PLANNER_TEMP}

}

#task sokoban lmcut "lmcut()"
#task sokoban ipdb "ipdb()"
task sokoban perfect "complexity(astar(lmcut(), undef_value=true, verbosity=SILENT))"

#task blocks lmcut "lmcut()"
#task blocks ipdb "ipdb()"
task blocks perfect "complexity(astar(lmcut(), undef_value=true, verbosity=SILENT))"

#task airport lmcut "lmcut()"
#task airport ipdb "ipdb()"
task airport perfect "complexity(astar(lmcut(), undef_value=true, verbosity=SILENT))"
