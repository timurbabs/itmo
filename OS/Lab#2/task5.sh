#!/usr/bin/env bash

ppid=0
count=0
art=0

while read line; do
	
    ppid_tmp=$(echo $line | cut -d ":" -f 2 | grep -E -s -o "[0-9]+")
	art_tmp=$(echo "$line" | grep -E -s -o "[0-9]*[.,]?[0-9]+$")

	if (( $ppid != $ppid_tmp && $count != '0' )); then
		art_ppid=$(echo "scale=7; $art/$count" | bc)
		echo "Average_Sleeping_Children_of_Parent=$ppid is $art_ppid"
		count=0
		art=0
	fi
    
    echo $line 
	ppid=$ppid_tmp
	art=$(echo "scale=7; $art+$art_tmp" | bc)
	count=$(($count+1))
done < ans4 > ans5

art_ppid=$(echo "scale=7; $art/$count" | bc)
echo "Average_Sleeping_Children_of_Parent=$ppid is $art_ppid" >> ans5
