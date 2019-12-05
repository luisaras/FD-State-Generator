#!/bin/bash
table() 
{
	TASK=$1/$2
	$i=$3 # Instance number

	GEN_OUTPUT=${TASK}/${i}_gen.txt
	PLAN_OUTPUT=${TASK}/${i}_plan.txt
	PLAN_OUTPUT_OLD=planner/$2/${i}_plan.txt

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

	echo "$2$i	$LENGTH_OLD	$LENGTH_NEW	$NODES_OLD	$NODES_NEW	$H_OLD	$H_NEW		$EXPANDED	$SEARCH_TIME	$TOTAL_TIME" >> ${TASK}.dat

}

#      <h> <w(h),h>   <c,h>        <w(h),c,h>           <c,w(h),h>
#ALLGEN=("" "novelty-" "conflicts-" "novelty-conflicts-" "conflicts-novelty-")
ALLGEN=("" "novelty-" "conflicts-")

instance() {
    for h in "${ALLH[@]}"; do
        for g in "${ALLGEN[@]}"; do
        	table $g$h $1 $2
        done
    done
}

instances_pyperplan() {
	ALLH=(lmcut ipdb astar)
    cd generator-tests-pyperplan
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
    local DOMAINS=(blocks sokoban airport)
	for p in "${DOMAINS[@]}"; do
	 	for i in $(seq 1 20); do
	 		instance $p $i
	 	done
	done
	cd ..
}

instances_simple() {
    ALLH=(lmcut ipdb fulldb)
	cd generator-tests-simple
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

find . -name "*.dat" -type f -delete

instances_simple
