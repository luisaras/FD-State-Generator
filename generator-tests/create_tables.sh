#!/bin/bash
table() 
{
    TASK=$1
    FOLDER=lmcut # Test folder where the output files are written
    
    for i in $(seq -w 1 10); do
        GEN_OUTPUT=${FOLDER}/${TASK}/${i}_gen.txt
        PLAN_OUTPUT=${FOLDER}/${TASK}/${i}_plan.txt

        EXPANDED=$(cat ${GEN_OUTPUT} | grep "Expanded" | tr -d "Expanded " | tr -d " state(s).")
        TIME=$(cat ${GEN_OUTPUT} | grep "Search time" | tr -d "Search time: " | tr -d " s")
        H_OLD=$(cat ${GEN_OUTPUT} | grep "Original state h\-value" | tr -d "Original state h\-value: ")
        H_NEW=$(cat ${GEN_OUTPUT} | grep "New state h\-value" | tr -d "New state h\-value: ")
        LENGTH=$(cat ${PLAN_OUTPUT} | grep "Plan cost" | tr -d "Plan cost: " | tr -d " step(s).")

        if ! [[ -z "${LENGTH}" ]];
        then
        	echo "$LENGTH	$H_OLD	$H_NEW	$EXPANDED	$TIME" >> "${TASK}.dat"
        else
        	echo "-	$H_OLD	$H_NEW	$EXPANDED	$TIME" >> "${TASK}.dat"
        fi
        
    done
}

rm *.dat
table sokoban
table airport
table blocks