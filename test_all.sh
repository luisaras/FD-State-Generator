PLANNER="astar(lmcut(), max_time=300000)" # Five minutes

generate() 
{
    # Parameters
    TASK=$1 # Problem name
    FOLDER=generator-tests/$2 # Test folder where the output files will be written
    HEURISTIC=$3 # Heuristic method to guide generation
    OPTS=$4 # Search options

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
        ./fast-downward.py ${TRANSLATOR_TEMP} --internal-plan-file ${NEW_TASK} $4 --search "generator_abstract([${HEURISTIC}], max_it=20000000, max_time=1200)" > ${GEN_OUTPUT}

        # Generate PDDL file for new task
        src/sas_to_pddl.py ${TASK_INPUT} ${NEW_TASK} ${NEW_TASK_PDDL}

        # Planner output files
        PLAN_OUTPUT=${OUTPUT_DIR}/${i}_plan.txt

        # Find plan for $i_task.sas
        ./fast-downward.py ${NEW_TASK} --internal-plan-file ${PLANNER_TEMP} --search "$PLANNER" > ${PLAN_OUTPUT}

    done

    # Delete temp files
    rm ${TRANSLATOR_TEMP}
    rm ${PLANNER_TEMP}

}

plan()
{
    # Parameters
    TASK=$1 # Problem name
    FOLDER=generator-tests/$2 # Test folder where the output files will be written
    SEARCH=$3 # Heuristic method to guide generation
    OPTS=$4 # Search options

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
        PLAN_OUTPUT=${OUTPUT_DIR}/${i}_plan.txt

        # Generate $i_task.sas
        ./fast-downward.py ${TRANSLATOR_TEMP} --internal-plan-file ${PLANNER_TEMP} $4 --search "${SEARCH}" > ${PLAN_OUTPUT}

    done

    # Delete temp files
    rm ${TRANSLATOR_TEMP}
    rm ${PLANNER_TEMP}

}


LMCUT="lmcut()"
IPDB="ipdb()"
ASTAR="complexity(astar(lmcut(), undef_value=true, verbosity=SILENT))"
EHC_1="complexity(ehc(cpdbs(systematic(1)), undef_value=true, verbosity=SILENT))"
EHC_2="complexity(ehc(cpdbs(systematic(2)), undef_value=true, verbosity=SILENT))"
EHC_3="complexity(ehc(cpdbs(systematic(3)), undef_value=true, verbosity=SILENT))"
PHO_2="operatorcounting([pho_constraints(systematic(2))])"
PHO_3="operatorcounting([pho_constraints(systematic(3))])"
CONFLICTS="pho3, pho2, sum([pho2, pho3])"
NOVELTY_GOALS_1="novelty_goal_count(level=1, undef_value=true, verbosity=SILENT)"
NOVELTY_GOALS_2="novelty_goal_count(level=2, undef_value=true, verbosity=SILENT)"
#NOVELTY_1="complexity(novelty_search(level=1, undef_value=true, verbosity=SILENT))"
#NOVELTY_2="complexity(novelty_search(level=2, undef_value=true, verbosity=SILENT))"

CONFLICTS_OPTS="--evaluator pho3=${PHO_3} --evaluator pho2=${PHO_2}"

for p in blocks sokoban airport; do
    #plan $p planner $PLANNER
    #generate $p lmcut "${LMCUT}"
    #generate $p ipdb "${IPDB}"
    generate $p conflicts "${CONFLICTS}" "${CONFLICTS_OPTS}"
    #generate $p novelty_1 "${NOVELTY_1}"
    #generate $p novelty_2 "${NOVELTY_2}"
    #generate $p width_1 "${WIDTH_1}"
    #generate $p width_2 "${WIDTH_2}"
    #generate $p width_3 "${WIDTH_3}"
    #generate $p all "${LMCUT}, ${IPDB}, ${NOVELTY_2}, ${WIDTH_2}"
    #generate $p perfect "${ASTAR}"
done
