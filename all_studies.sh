#!/bin/bash

scheduling_algorithms=("RR" "Qos" "PF" "MR")
runs=(1 2 3 5 8 10)

#Flag for what study to run
flag_1=true
flag_2=true
flag_3=false

for run in "${runs[@]}"; do
	#For Study 1
	if $flag_1; then
	    for algorithm in "${scheduling_algorithms[@]}"; do
		for distance in $(seq 100 100 2000); do
		    ./ns3 run "scratch/study1/study1 --sched=$algorithm --simTime=15 --distance=$distance --run=$run"
		done
	    done
	fi

	#For Study 2
	if $flag_2; then
	    for algorithm in "${scheduling_algorithms[@]}"; do
		for ueNumPergNb in $(seq 5 5 20); do
		    ./ns3 run "scratch/study2/study2 --sched=$algorithm simTime=15 --ueNumPergNb=$ueNumPergNb --run=$run"
		done
	    done
	fi

	#For Study 3
	if $flag_3; then
	    for algorithm in "${scheduling_algorithms[@]}"; do
		./ns3 run "scratch/study3/study3 --schedulerType=$algorithm --simTime=15 --run=$run"
	    done
	fi
done
