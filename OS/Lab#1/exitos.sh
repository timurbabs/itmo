#!/usr/bin/env bash

exitos()
{
if [ "$2" != "i" ]; then
    if [ -z $1 ]; then
        exit 0
    elif ! [[ $1 =~ ^[0-9]+$ ]] || ! [[ $1 -lt 256 ]] || ! [[ $1 -ge 0 ]]; then
        echo -e "\e[31mNeed number from 0 to 255.\e[0m"
        exit 1001
    else
        exit $1
    fi

elif [ "$2" == "i" ]; then
    if [ -z $1 ]; then
        exit 0
    elif ! [[ $1 =~ ^[0-9]+$ ]] || ! [[ $1 -lt 256 ]] || ! [[ $1 -ge 0 ]]; then
        echo -e "\e[31mNeed number from 0 to 255.\e[0m" >&2
        return 1001
    else
        exit $1
    fi
    
fi
}
