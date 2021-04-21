#!/usr/bin/env bash

max_pid=0
max_mem=0

for pid in $(ps -e -o pid); do
    cur_size=$(grep -s "VmSize" "/proc/"$pid"/status" | grep -E -s -o "[0-9]+")

if [[ $cur_size -gt $max_mem ]]; then
    max_pid=$pid
    max_mem=$cur_size
fi
done

top_pid=$(top -b -o +VIRT | head -n 8 | tail -n 1 | awk '{print $1}')
top_mem=$(top -b -o +VIRT | head -n 8 | tail -n 1 | awk '{print $5}')

echo "Max PID in /proc: $max_pid"
echo "MEM in /proc:     $max_mem"
echo "Max PID in top:   $top_pid"
echo "MEM in top:  $top_mem"
