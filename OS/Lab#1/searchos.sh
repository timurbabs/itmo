#!/usr/bin/env bash

searchos()
{
if [ "$3" != "i" ]; then
    critical check_dir_exist "$1"
    critical check_read "$1"
    grep -rs "$2" "$1"
    exit 0
elif [ "$3" == "i" ]; then
    check_dir_exist "$1"
    if [ $? -eq 6 ]; then
        return 6
    fi
    check_read "$1"
    if [ $? -eq 3 ]; then
        return 3
    fi
    grep -rs "$2" "$1"
fi 
}
