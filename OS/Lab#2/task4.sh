#!/usr/bin/env bash

for pid in $(ps -e -o pid); do
    path1="/proc/"$pid"/status"
    path2="/proc/"$pid"/sched"

    ppid=$(grep -s "PPid" $path1 | grep -E -s -o "[0-9]+")
    sum=$(grep -s "sum_exec_runtime" $path2 | grep -E -s -o "[0-9]*[.,]?[0-9]+")
    nr=$(grep -s "nr_switches" $path2 | grep -E -s -o "[0-9]+")
if [[ -n $nr ]]; then
    art=$(echo "scale=7; $sum/$nr" | bc -l)
    echo "ProcessID=$pid : Parent_ProcessID=$ppid : Average_Running_Time=$art"
fi
done | sort -n -t '=' -k3 > ans4
