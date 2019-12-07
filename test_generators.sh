PLANNER="astar(lmcut())" # Five minutes
# Temp files
TRANSLATOR_TEMP=output.sas
SEARCH_TEMP=sas_plan

PLANNER_TIME=300 # 5 minutes
PLANNER_MEM=2000000 # 2GB

set_output_dir() {
    # Create folders
    local METHOD=$1
    local TASK=$2
    if [ ! -d $TEST_FOLDER ]; then
        mkdir $TEST_FOLDER
    fi
    if [ ! -d $TEST_FOLDER/$METHOD ]; then
        mkdir $TEST_FOLDER/$METHOD
    fi
    if [ ! -d $TEST_FOLDER/$METHOD/$TASK ]; then
        mkdir $TEST_FOLDER/$METHOD/$TASK
    fi
    # Output directory 
    OUTPUT_DIR=$TEST_FOLDER/$METHOD/$TASK
}

set_files_ipc() {
    # Input directory
    local PDDL_DIR=../ipc/$1
    # Input files
    DOMAIN_INPUT=${PDDL_DIR}/domain.pddl
    TASK_INPUT=${PDDL_DIR}/$2.pddl
}

set_files_ipc11() {
    # Input directory
    local PDDL_DIR=../pddl-instances/ipc-2011/domains/$1-sequential-optimal
    # Input files
    DOMAIN_INPUT=${PDDL_DIR}/domain.pddl
    if [ ! -f $DOMAIN_INPUT ]; then
        DOMAIN_INPUT=${PDDL_DIR}/domains/domain-$2.pddl
    fi
    TASK_INPUT=${PDDL_DIR}/instances/instance-$2.pddl
}

set_files_pyperplan() {
    # Input directory
    local PDDL_DIR=../pyperplan/benchmarks/$1
    # Input files
    DOMAIN_INPUT=${PDDL_DIR}/domain$2.pddl
    if [ ! -f $DOMAIN_INPUT ]; then
        DOMAIN_INPUT=${PDDL_DIR}/domain.pddl
    fi
    TASK_INPUT=${PDDL_DIR}/task$2.pddl
}

generate()  {
    # Parameters
    local TASK=$1 # Problem name
    local i=$2 # Instance number
    local GENERATOR=gen-$3 # Generator alias

    set_files_$BENCHMARKS $TASK $i
    set_output_dir $3 $TASK

    # Generator output files
    NEW_TASK=${OUTPUT_DIR}/${i}_task.sas
    NEW_TASK_PDDL=${OUTPUT_DIR}/${i}_task.pddl
    GEN_OUTPUT=${OUTPUT_DIR}/${i}_gen.txt

    echo $GENERATOR $TASK$i

    # Translate to output.sas
    if [ -f $TRANSLATOR_TEMP ]; then
        rm $TRANSLATOR_TEMP
    fi
    local TRANSLATOR_MSG=$(
        ./fast-downward.py --translate --sas-file $TRANSLATOR_TEMP $DOMAIN_INPUT $TASK_INPUT --translator-options --unit-costs
    )
    if [ ! -f $TRANSLATOR_TEMP ]; then
        echo $TRANSLATOR_MSG
        return 0
    fi

    # Generate $i_task.sas
    ulimit -S -v unlimited
    ulimit -S -t $GEN_TIME
    if [ -f $SEARCH_TEMP ]; then
        rm $SEARCH_TEMP
    fi
    ./fast-downward.py --alias $GENERATOR $TRANSLATOR_TEMP > $GEN_OUTPUT
    rm $TRANSLATOR_TEMP
    if [ ! -f $SEARCH_TEMP ]; then
        cat $GEN_OUTPUT
        return 0
    fi
    cat $SEARCH_TEMP > $NEW_TASK

    # Generate PDDL file for new task
    local PDDL_MSG=$(
        src/sas_to_pddl.py $TASK_INPUT $NEW_TASK $NEW_TASK_PDDL
    )
    if [ ! -f $NEW_TASK_PDDL ]; then
        echo $PDDL_MSG
        return 0
    fi

    # Planner output files
    PLAN_OUTPUT=${OUTPUT_DIR}/${i}_plan.txt

    # Find plan for $i_task.sas
    ulimit -S -v $PLANNER_MEM
    ulimit -S -t $PLANNER_TIME
    local PLANNER_MSG=$(
        ./fast-downward.py $NEW_TASK --internal-plan-file $SEARCH_TEMP --search "$PLANNER" > $PLAN_OUTPUT
    )
    if [ ! -f $SEARCH_TEMP ]; then
        echo $PLANNER_MSG
        return 0
    fi
    rm $SEARCH_TEMP
}

plan() {
    # Parameters
    local TASK=$1 # Problem name
    local i=$2 # Instance number
    local SEARCH=$3 # Heuristic method to guide generation

    set_files_$BENCHMARKS $TASK $i
    set_output_dir planner $TASK

    # Translate to output.sas
    if [ -f $TRANSLATOR_TEMP ]; then
        rm $TRANSLATOR_TEMP
    fi
    TRANSLATOR_MSG=$(
        ./fast-downward.py --translate --sas-file $TRANSLATOR_TEMP $DOMAIN_INPUT $TASK_INPUT --translator-options --unit-costs
    )
    if [ ! -f $TRANSLATOR_TEMP ]; then
        echo $TRANSLATOR_MSG
        return 0
    fi

    # Planner output files
    PLAN_OUTPUT=${OUTPUT_DIR}/${i}_plan.txt

    # Find plan for output.sas
    ulimit -S -v $PLANNER_MEM
    ulimit -S -t $PLANNER_TIME
    if [ -f $SEARCH_TEMP ]; then
        rm $SEARCH_TEMP
    fi
    local PLANNER_MSG=$(
        ./fast-downward.py $TRANSLATOR_TEMP --internal-plan-file $SEARCH_TEMP --search "$SEARCH" > $PLAN_OUTPUT
    )
    rm $TRANSLATOR_TEMP
    if [ ! -f $SEARCH_TEMP ]; then
        echo $PLANNER_MSG
        return 0
    fi
    rm $SEARCH_TEMP
}

#       <h> <w(h),h>   <c,h>        <w(h),c,h>           <c,w(h),h>
#ALLGEN=("" "novelty-" "conflicts-" "novelty-conflicts-" "conflicts-novelty-")
ALLGEN=("" "novelty-" "conflicts-")

test() {
    local PROBLEM=$1
    local INST=$2
    if [ -z "$PLAN" ]
        plan $1 $2 $PLANNER
    fi
    for h in "${ALLH[@]}"; do
        for g in "${ALLGEN[@]}"; do
            generate $PROBLEM $INST $g$h$LIMIT $BENCHMARKS
        done
    done
}

test_pyperplan() {
    ALLH=(lmcut ipdb astar)
    BENCHMARKS=pyperplan
    TEST_FOLDER=generator-tests-pyperplan
    local DOMAINS=(blocks sokoban airport)
    for p in "${DOMAINS[@]}"; do
        for i in $(seq -w 1 10); do
            test $p $i
        done
    done
}

test_ipc11() {
    ALLH=(lmcut ipdb astar)
    BENCHMARKS=ipc11
    TEST_FOLDER=generator-tests-ipc11
    local DOMAINS=(barman elevator floor-tile no-mystery openstacks parc-printer parking peg-solitaire scanalyzer-3d sokoban storage tidybot transport visit-all woodworking)
    for p in "${DOMAINS[@]}"; do
        for i in $(seq 1 20); do
            test $p $i
        done
    done
}

test_simple_old() {
    ALLH=(lmcut ipdb fulldb)
    BENCHMARKS=ipc11
    TEST_FOLDER=generator-tests-simple-old
    test elevator 1
    test no-mystery 1
    test no-mystery 2
    test no-mystery 3
    test no-mystery 11
    test no-mystery 12
    test no-mystery 13
    test no-mystery 14
    test parc-printer 5
    test parc-printer 8
    test scanalyzer-3d 1
    test scanalyzer-3d 2
    test scanalyzer-3d 3
    test sokoban 19
    test transport 1
    test transport 2
    test transport 3
    test visit-all 1
    test visit-all 2
    test visit-all 3
    test visit-all 4
    test visit-all 5
    test visit-all 6
    test visit-all 8
    test visit-all 10
    test woodworking 11
}

test_simple() {
    ALLH=(lmcut ipdb fulldb)
    BENCHMARKS=ipc
    TEST_FOLDER=generator-tests-simple
    test blocks probBLOCKS-4-0
    test blocks probBLOCKS-6-0
    test blocks probBLOCKS-7-2
    test elevators-opt08-strips p01
    test elevators-opt08-strips p03
    test elevators-opt08-strips p11
    test gripper prob01
    test gripper prob03
    test gripper prob05
    test visitall-opt11-strips problem02-full
    test visitall-opt11-strips problem04-full
    test visitall-opt11-strips problem06-half
    test miconic s1-0
    test miconic s5-2
    test miconic s11-4
    test parcprinter-08-strips p01
    test parcprinter-08-strips p11
    test parcprinter-08-strips p21
    cd ..
}

LIMIT=$2
if [ -z "$2" ]
then
    GEN_TIME=910
else
    GEN_TIME=310
fi

PLAN=$3

test_$1

#./test_generators.sh simple -limited plan ; ./test_generators.sh simple