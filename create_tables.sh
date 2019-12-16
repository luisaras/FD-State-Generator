#!/bin/bash
table() 
{
	TASK=$1/$2

	GEN_OUTPUT=${TASK}/${3}_gen.txt
	PLAN_OUTPUT=${TASK}/${3}_plan.txt
	PLAN_OUTPUT_OLD=planner/$2/${3}_plan.txt

	EXPANDED=$(grep "Expanded" ${GEN_OUTPUT} | tr -d "Expanded " | tr -d " state(s).")
	SEARCH_TIME=$(grep "Search time" ${GEN_OUTPUT} | tr -d "Search time: " | tr -d " s")
	TOTAL_TIME=$(grep "Total time" ${GEN_OUTPUT} | tr -d "Total time: " | tr -d " s")
	H_OLD=$(grep "Original state" ${GEN_OUTPUT} | tr -d "Original state h\-value: ")
	H_NEW=$(grep "New state" ${GEN_OUTPUT} | tr -d "New state h\-value: ")
	
	LENGTH_NEW=$(grep "Plan length" ${PLAN_OUTPUT} | tr -d "Plan length: " | tr -d " step(s).")
	NODES_NEW=$(grep -m 1 "Expanded" ${PLAN_OUTPUT} | tr -d "Expanded " | tr -d " state(s).")
	if [[ -z ${LENGTH_NEW} ]];
	then
		LENGTH_NEW="-"
		NODES_NEW="-"
	fi

	LENGTH_OLD=$(grep "Plan length" ${PLAN_OUTPUT_OLD} | tr -d "Plan length: " | tr -d " step(s).")
	NODES_OLD=$(grep -m 1 "Expanded" ${PLAN_OUTPUT_OLD} | tr -d "Expanded " | tr -d " state(s).")
	if [[ -z ${LENGTH_OLD} ]];
	then
		LENGTH_OLD="-"
		NODES_OLD="-"
	fi

	echo "$2$3	$LENGTH_OLD	$LENGTH_NEW	$NODES_OLD	$NODES_NEW	$H_OLD	$H_NEW		$EXPANDED	$SEARCH_TIME	$TOTAL_TIME" >> ${TASK}.dat
    echo "$2$3	$LENGTH_OLD	$LENGTH_NEW	$NODES_OLD	$NODES_NEW	$H_OLD	$H_NEW		$EXPANDED	$SEARCH_TIME	$TOTAL_TIME" >> $1/all_tasks.dat

}

#      <h> <w(h),h>   <c,h>        <w(h),c,h>           <c,w(h),h>
#ALLGEN=("" "novelty-" "conflicts-" "novelty-conflicts-" "conflicts-novelty-")
ALLGEN=("" "novelty-" "novelty2-" "conflicts-")

instance() {
    for h in "${ALLH[@]}"; do
        for g in "${ALLGEN[@]}"; do
        	table $g$h $1 $2
        	table $g$h-limited $1 $2
        done
    done
}

instances_pyperplan() {
	ALLH=(lmcut ipdb astar)
    cd generator-tests-pyperplan
    find . -name "*.dat" -type f -delete
    local DOMAINS=(blocks sokoban airport)
	for p in "${DOMAINS[@]}"; do
	 	for i in $(seq -w 1 10); do
	 		instance $p $i
	 	done
	done
	cd ..
}

instances_ipc11() {
	ALLH=(lmcut ipdb astar)
    cd generator-tests-ipc11
    find . -name "*.dat" -type f -delete
    local DOMAINS=(blocks sokoban airport)
	for p in "${DOMAINS[@]}"; do
	 	for i in $(seq 1 20); do
	 		instance $p $i
	 	done
	done
	cd ..
}

instances_simple_ipc11() {
    ALLH=(lmcut ipdb fulldb)
	cd generator-tests-simple
	find . -name "*.dat" -type f -delete
    instance elevator 1
    instance no-mystery 1
    instance no-mystery 2
    instance no-mystery 3
    instance no-mystery 11
    instance no-mystery 12
    instance no-mystery 13
    instance no-mystery 14
    instance parc-printer 5
    instance parc-printer 8
    instance scanalyzer-3d 1
    instance scanalyzer-3d 2
    instance scanalyzer-3d 3
    instance sokoban 19
    instance transport 1
    instance transport 2
    instance transport 3
    instance visit-all 1
    instance visit-all 2
    instance visit-all 3
    instance visit-all 4
    instance visit-all 5
    instance visit-all 6
    instance visit-all 8
    instance visit-all 10
    instance woodworking 11
    
	cd ..
}

instances_simple() {
    ALLH=(lmcut ipdb fulldb)
	cd generator-tests-simple
	find . -name "*.dat" -type f -delete
    instance blocks probBLOCKS-4-0
    instance blocks probBLOCKS-6-0
    instance blocks probBLOCKS-7-2
    instance elevators-opt08-strips p01
    instance elevators-opt08-strips p03
    instance elevators-opt08-strips p11
    instance gripper prob01
    instance gripper prob03
    instance gripper prob05
    instance visitall-opt11-strips problem02-full
    instance visitall-opt11-strips problem04-full
    instance visitall-opt11-strips problem06-half
    instance miconic s1-0
    instance miconic s5-2
    instance miconic s11-4
    instance parcprinter-08-strips p01
    instance parcprinter-08-strips p11
    instance parcprinter-08-strips p21
    cd ..
}

instances_blocks_sokoban_simple() {
    ALLH=(lmcut ipdb fulldb)
    cd generator-tests-simple
    find . -name "*.dat" -type f -delete
    instance blocks probBLOCKS-4-0
    instance blocks probBLOCKS-4-1
    instance blocks probBLOCKS-4-2
    instance blocks probBLOCKS-5-0
    instance blocks probBLOCKS-5-1
    instance blocks probBLOCKS-5-2
    instance blocks probBLOCKS-6-0
    instance blocks probBLOCKS-6-1
    instance blocks probBLOCKS-6-2
    instance blocks probBLOCKS-7-0
    instance blocks probBLOCKS-7-1
    instance blocks probBLOCKS-7-2
    ALLH=(lmcut ipdb)
    instance sokoban-opt11-strips p01
    instance sokoban-opt11-strips p02
    instance sokoban-opt11-strips p03
    instance sokoban-opt11-strips p04
    instance sokoban-opt11-strips p05
    cd ..
}


instances_$1
