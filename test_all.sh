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
        NEW_TASK_PDDL=${OUTPUT_DIR}/${i}_task.pddl
        GEN_OUTPUT=${OUTPUT_DIR}/${i}_gen.txt

        # Generate $i_task.sas
        ./fast-downward.py ${TRANSLATOR_TEMP} --internal-plan-file ${NEW_TASK} --search "generator_abstract([${HEURISTIC}], max_it=20000000, max_time=1200)" > ${GEN_OUTPUT}

        # Generate PDDL file for new task
        src/sas_to_pddl.py ${TASK_INPUT} ${NEW_TASK} ${NEW_TASK_PDDL}

        # Planner output files
        PLAN_OUTPUT=${OUTPUT_DIR}/${i}_plan.txt

        # Find plan for $i_task.sas
        ./fast-downward.py ${NEW_TASK} --internal-plan-file ${PLANNER_TEMP} --search "astar(lmcut())" > ${PLAN_OUTPUT}

    done

    # Delete temp files
    rm ${TRANSLATOR_TEMP}
    rm ${PLANNER_TEMP}

}

LMCUT="lmcut()"
IPDB="ipdb()"
ASTAR="complexity(astar(lmcut(), undef_value=true, verbosity=SILENT))"
NOVELTY_1="complexity(novelty_search(level=1, undef_value=true, verbosity=SILENT))"
NOVELTY_2="complexity(novelty_search(level=2, undef_value=true, verbosity=SILENT))"
WIDTH_1="complexity(ehc(cpdbs(systematic(1)), undef_value=true, verbosity=SILENT))"
WIDTH_2="complexity(ehc(cpdbs(systematic(2)), undef_value=true, verbosity=SILENT))"
WIDTH_3="complexity(ehc(cpdbs(systematic(3)), undef_value=true, verbosity=SILENT))"

for p in blocks sokoban airport; do
    task $p lmcut ${LMCUT}
    task $p ipdb ${IPDB}
    #task $p perfect ${ASTAR}
    task $p novelty_1 ${NOVELTY_1}
    task $p novelty_2 ${NOVELTY_2}
    task $p width_1 ${WIDTH_1}
    task $p width_2 ${WIDTH_2}
    task $p width_3 ${WIDTH_3}
    task $p all "${LMCUT}, ${IPDB}, ${NOVELTY_2}, ${WIDTH_2}"
done
