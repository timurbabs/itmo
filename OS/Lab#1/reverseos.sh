#!/usr/bin/env bash

reverseos()
{
if [ "$3" != "i" ]; then
    if [ $1 == $2 ]; then
        rev $1 >> $2
        exit 0
    fi
    critical check_file_exist $1
    critical check_read $1
    if [[ -e "$2" ]] && [[ ! -w "$2" ]] || [[ -d "$2" ]] || ! touch "$2" 2> /dev/null; then
        echo -e "\e[31mCan't write in: '$2'\e[0m."
        exit 7
    fi
    rev $1 > $2
    exit 0
     
elif [ "$3" == "i" ]; then
    if [ $1 == $2 ]; then
        rev $1 >> $2
        return 0
    fi
    check_file_exist $1
    if [ $? eq 7 ]; then
        return 7
    fi
    check_read $1
    if [ $? eq 3 ]; then
        return 3
    fi
    if [[ -e "$2" ]] && [[ ! -w "$2" ]] || [[ -d "$2" ]] || ! touch "$2" 2> /dev/null; then
        echo -e "\e[31mCan't write in: '$2'\e[0m."
        return 7
    fi
    rev $1 > $2
    return 0
fi
}
