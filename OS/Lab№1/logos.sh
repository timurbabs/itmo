#!/usr/bin/env bash

logos()
{
if [ "$1" != "i" ]; then
    critical check_file_exist "/var/log/anaconda/X.log"
    critical check_read "/var/log/anaconda"
    critical check_read "/var/log/anaconda/X.log"
    
    while read line; do
        if [[ "$line" == *"(WW)"* && "$line" != *"(WW) warning, (EE) error, (NI) not implemented, (??) unknown."* ]]; then
            echo -e ${line//"(WW)"/"\e[33mWarning:\e[0m"}
        fi
    done < "/var/log/anaconda/X.log"
    while read line; do
        if [[ "$line" == *"(II)"* && "$line" != *"(++) from command line, (!!) notice, (II) informational,"* ]]; then
            echo -e ${line//"(II)"/"\e[94mInformation:\e[0m"}
        fi
    done < "/var/log/anaconda/X.log"

elif [ "$1" == "i" ]; then
    check_file_exist "/var/log/anaconda/X.log"
    if [ $? -eq 7 ]; then
        return 7;
    fi
    check_read "/var/log/anaconda"
    if [ $? -eq 3 ]; then
        return 3;
    fi
    check_read "/var/log/anaconda/X.log"
    if [ $? -eq 3 ]; then
        return 3;
    fi

    while read line; do
        if [[ "$line" == *"(WW)"* && "$line" != *"(WW) warning, (EE) error, (NI) not implemented, (??) unknown."* ]]; then
            echo -e ${line//"(WW)"/"\e[33mWarning:\e[0m"}
        fi
    done < "/var/log/anaconda/X.log"
    while read line; do
        if [[ "$line" == *"(II)"* && "$line" != *"(++) from command line, (!!) notice, (II) informational,"* ]]; then
            echo -e ${line//"(II)"/"\e[94mInformation:\e[0m"}
        fi
    done < "/var/log/anaconda/X.log"
fi 
}
