#!/usr/bin/env bash

calcos()
{
if [ "$4" != "i" ]; then

    if [ "$1" != "sum" ] && [ "$1" != "div" ] && [ "$1" != "mul" ] && [ "$1" != "sub" ]; then
        echo -e "\e[31mWrong action: \"$1\".\e[0m" >&2;
        exit 11	
    elif ! [[ $2 =~ ^(-|\+)?[0-9]+$ ]] || ! [[ $3 =~ ^(-|\+)?[0-9]+$ ]]; then
        echo -e "\e[31mNeed integer.\e[0m" >&2;
        exit 12
    elif [ "$1" == "sum" ]; then
        echo $(($2+$3)) 
    elif [ "$1" == "sub" ]; then
        echo $(($2-$3))
    elif [ "$1" == "div" ]; then
        if [ $3 == "0" ] || [ $3 == "-0" ] || [ $3 == "+0" ]; then
            echo -e "\e[31mDivision by zero.\e[0m" >&2;
            exit 13	
        else
            echo $(($2/$3))
        fi
    elif [ "$1" == "mul" ]; then
        echo $(($2*$3))
    fi

elif [ "$4" == "i" ]; then   

    if [ "$1" != "sum" ] && [ "$1" != "div" ] && [ "$1" != "mul" ] && [ "$1" != "sub" ]; then
        echo -e "\e[31mWrong action: \"$1\".\e[0m" >&2;
        return 11
    elif ! [[ $2 =~ ^(-|\+)?[0-9]+$ ]] || ! [[ $3 =~ ^(-|\+)?[0-9]+$ ]]; then
        echo -e "\e[31mNeed integer.\e[0m" >&2;
        return 12
    elif [ "$1" == "sum" ]; then
        echo $(($2+$3)) 
    elif [ "$1" == "sub" ]; then
        echo $(($2-$3))
    elif [ "$1" == "div" ]; then
        if [ $3 == "0" ] || [ $3 == "-0" ] || [ $3 == "+0" ]; then
            echo -e "\e[31mDivision by zero.\e[0m" >&2;
            return 13
        else
            echo $(($2/$3))
        fi
    elif [ "$1" == "mul" ]; then
        echo $(($2*$3))
    fi
    
fi
}
