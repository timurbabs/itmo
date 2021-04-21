#!/usr/bin/env bash

tmp=$(ps --no-headers -u timurbabs -o pid,command)

if [[ $tmp == "" ]]; then
    echo "0" > answer1.log
else
	echo "$tmp" | wc -l > ans1
	echo "$tmp" >> ans1 
fi
