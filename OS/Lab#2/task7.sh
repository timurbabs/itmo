#!/usr/bin/env bash

for i in $(ps -e -o pid,command | awk '{print $1":"$2}'); do
    pid=$(echo $i | cut -d ":" -f 1)
    cmd=$(echo $i | cut -d ":" -f 2)
    pastReadBytes=$(grep -s "read_bytes" "/proc/"$pid"/io" | grep -E -s -o "[0-9]+")
if [[ -n $pastReadBytes ]]; then
    echo "$pid:$cmd:$pastReadBytes"
fi
done > temp
sleep 10s

for i in $(ps -e -o pid,command | awk '{print $1":"$2}' ); do
    pid=$(echo $i | cut -d ":" -f 1)
    cmd=$(echo $i | cut -d ":" -f 2)
    newReadBytes=$(grep -s "read_bytes" "/proc/"$pid"/io" | grep -E -s -o "[0-9]+")
    if [[ -z $newReadBytes ]]; then
        continue
    fi
    pastReadBytes=$(cat temp | grep "^$pid:" | cut -d ":" -f 3)
if [[ -n $pastReadBytes ]]; then
    readBytes=$(echo "scale=7; $newReadBytes-$pastReadBytes" | bc -l)
    echo "$pid:$cmd:$readBytes"
fi
done | sort -n -t ':' -k 3 -r | head -3
rm temp
