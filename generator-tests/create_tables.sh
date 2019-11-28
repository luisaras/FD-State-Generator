#!/bin/bash
table() 
{
	TASK=$1/$2
	if [ -f ${TASK}.dat ]; then
		rm ${TASK}.dat
	fi

	for i in $(seq -w 1 10); do

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
		
	done
}

table lmcut sokoban
table lmcut blocks
table lmcut airport
table ipdb sokoban
table ipdb blocks
table ipdb airport
table perfect sokoban
table perfect blocks
table perfect airport