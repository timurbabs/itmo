#!/usr/bin/env bash

critical()
{
    $@
    RET_CODE=$?
    if [ $RET_CODE -ne 0 ]; then
        exit $RET_CODE
    fi
}

check_read()
{
    if ! [ -r "$1" ]; then
        echo -e "\e[31mDon't have permissions to read: '$1'.\e[0m" >&2
        return 3
    fi
}

check_write()
{
    if ! [ -w "$1" ]; then
        echo -e "\e[31mDon't have permissions to write: '$1'.\e[0m" >&2
        return 4
    fi
}

check_execute()
{
    if ! [ -x "$1" ]; then
        echo -e "\e[31mDon't have permissions to execute: '$1'.\e[0m" >&2
        return 5
    fi
}

check_dir_exist()
{
    if ! [ -d "$1" ]; then
        echo -e "\e[31mCan't find directory: '$1'. Or it is a file.\e[0m" >&2
        return 6
    fi
}

check_file_exist()
{
    if ! [ -f "$1" ]; then
        echo -e "\e[31mCan't find file: '$1'. Or it is a directory.\e[0m" >&2
        return 7 
    fi
}

check_arg_count()
{
    if [ $1 -ne $2 ]; then
        echo -e "\e[31mInvalid number of arguments, need '$2'.\e[0m" >&2
        return 2
    fi
}

case "$1" in
    calc)
        critical check_file_exist calcos.sh
        critical check_read calcos.sh
        critical check_arg_count $# 4
        source calcos.sh
        calcos $2 $3 $4
    ;;

    search)
        critical check_file_exist searchos.sh
        critical check_read searchos.sh
        critical check_arg_count $# 3
        source searchos.sh
        searchos $2 "$3"
    ;;

    reverse)
        critical check_file_exist reverseos.sh
        critical check_read reverseos.sh
        critical check_arg_count $# 3
        source reverseos.sh
        reverseos "$2" "$3"  
    ;;

    strlen)
        critical check_file_exist strlenos.sh
        critical check_read strlenos.sh
        critical check_arg_count $# 2
        source strlenos.sh
        strlenos "$2"    
    ;;

    log)
        critical check_file_exist logos.sh
        critical check_read logos.sh
        critical check_arg_count $# 1
        source logos.sh
        logos
    ;;
    
    help)
        critical check_file_exist helpos.sh
        critical check_read helpos.sh
        critical check_arg_count $# 1
        source helpos.sh
        helpos
    ;;
     
    interactive)
        critical check_file_exist interactiveos.sh
        critical check_read interactiveos.sh
        critical check_arg_count $# 1
        source interactiveos.sh
        interactiveos
    ;;
 
    exit)
        critical check_file_exist exitos.sh
        critical check_read exitos.sh
        if [ $# -gt 2 ]; then
            echo -e "\e[31mInvalid number of arguments, need less than '3'.\e[0m" >&2
        else
            source exitos.sh
            exitos $2
        fi
    ;;

    *)
        echo -e "\e[31mDidn't chose a right option.\e[0m"    
        critical check_file_exist helpos.sh
        critical check_read helpos.sh
        source helpos.sh
        helpos
    ;;
esac

exit 0
