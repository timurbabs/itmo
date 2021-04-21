#!/usr/bin/env bash

menu()
{
    echo 
    echo -e "\e[33mMENU\e[0m"
    echo
    echo -e "\e[32mc)    calc.\e[0m"
    echo -e "\e[32ms)    search.\e[0m"
    echo -e "\e[32mr)    reverse.\e[0m"
    echo -e "\e[32mb)    strlen.\e[0m"
    echo -e "\e[32mh)    help.\e[0m"
    echo -e "\e[32ml)    log.\e[0m"
    echo -e "\e[32me)    exit.\e[0m"
    echo
    echo -e "\e[32mType character.\e[0m"
    echo
}

interactiveos()
{
    while [ 1 -eq 1 ]
    do
        menu
        read OPTION
        case $OPTION in
            c)
                check_file_exist calcos.sh
                if [ $? -eq 7 ]; then
                    continue
                fi
                check_read calcos.sh
                if [ $? -eq 3 ]; then
                    continue
                fi
                
                echo "Type back to back to menu or sum/sub/mul/div and after two numbers."
 
                read ACT NUM1 NUM2 OTHER
                if [ "$ACT" == "back" ]; then
                    if ! [ -z "$NUM1" ] || ! [ -z "$NUM2" ] || ! [ -z "$OTHER" ]; then
                        echo -e "\e[31mToo many arguments for 'back', need '1'.\e[0m" >&2
                        continue
                    fi
                    continue
                fi
                if [ -z "$NUM1" ] || [ -z "$NUM2" ]; then
                    echo -e "\e[31mWrite command 'NUM1' and 'NUM2'.\e[0m" >&2
                    continue
                fi
                if ! [ -z "$OTHER" ]; then
                    echo -e "\e[31mInvalid number of arguments, need '3'.\e[0m" >&2
                    continue
                fi
                source calcos.sh
                calcos $ACT $NUM1 $NUM2 "i"
            ;;

            s)
                check_file_exist searchos.sh
                if [ $? -eq 7 ]; then
                    continue
                fi
                check_read searchos.sh
                if [ $? -eq 3 ]; then
                    continue
                fi
                
                echo "Type back to back to menu or directory and regular expression to search."

                read DIR1 REG OTHER
                DIR=${DIR1/#~/$HOME}  
                if [ "$DIR" == "back" ]; then
                    if ! [ -z "$REG" ] || ! [ -z "$OTHER" ]; then
                        echo -e "\e[31mToo many arguments for 'back', need '1'.\e[0m" >&2
                        continue
                    fi
                    continue
                fi
                if [ -z "$REG" ]; then
                    echo -e "\e[31mWrite 'REG' and 'DIR'.\e[0m" >&2
                    continue
                fi
                if ! [ -z "$OTHER" ]; then
                    echo -e "\e[31mInvalid number of arguments, need '2'.\e[0m" >&2
                    continue
                fi
                source searchos.sh
                searchos "$DIR" "$REG" "i"
            ;;

            r)
                check_file_exist reverseos.sh
                if [ $? -eq 7 ]; then
                    continue
                fi
                check_read reverseos.sh
                if [ $? -eq 3 ]; then
                    continue
                fi
                    
                echo "Type back to back to menu or path to file and the path to another where need to write reverted text."

                read NOR1 REV1 OTHER
                NOR=${NOR1/#~/$HOME}  
                REV=${REV1/#~/$HOME}  
                if [ "$NOR" == "back" ]; then
                    if ! [ -z "$REV" ] || ! [ -z "$OTHER" ]; then
                        echo -e "\e[31mToo many arguments for 'back', need '1'.\e[0m" >&2
                        continue
                    fi
                    continue
                fi
                if [ -z "$NOR" ]; then
                    echo -e "\e[31mWrite 'NOR' and 'REV'.\e[0m" >&2
                    continue
                fi
                if ! [ -z "$OTHER" ]; then
                    echo -e "\e[31mInvalid number of arguments, need '2'.\e[0m" >&2
                    continue
                fi
                source reverseos.sh
                reverseos "$NOR" "$REV" "i"
            ;;

            b)
                check_file_exist strlenos.sh
                if [ $? -eq 7 ]; then
                    continue
                fi
                check_read strlenos.sh
                if [ $? -eq 3 ]; then
                    continue
                fi
                
                echo "Type back to back to menu or write string to count it."
                
                read STRING                
                if [ "$STRING" == "back" ]; then
                    continue
                fi
                if [ -z "$STRING" ]; then
                    echo -e "\e[31mWrite 'STRING'.\e[0m" >&2
                    continue
                fi
                source strlenos.sh
                strlenos "$STRING"
            ;;

            l)
                check_file_exist logos.sh
                if [ $? -eq 7 ]; then
                    continue
                fi
                check_read logos.sh
                if [ $? -eq 3 ]; then
                    continue
                fi

                source logos.sh
                logos "i"
                ERROR=$?
                if [ $ERROR -eq 3 ] || [ $ERROR -eq 7 ]; then
                    continue
                fi
                echo 
                echo "Press 'ENTER' or type any key to show menu."
                read BACK OTHER
                if ! [ -z "$OTHER" ]; then
                    echo -e "\e[31mInvalid number of arguments, need '1'.\e[0m" >&2
                    continue
                fi
                if [ -n $BACK ]; then
                    continue
                fi
   
            ;;
    
            h)
                check_file_exist helpos.sh
                if [ $? -eq 7 ]; then
                    continue
                fi
                check_read helpos.sh
                if [ $? -eq 3 ]; then
                    continue
                fi

                ERROR=$?
                if [ $ERROR -eq 3 ] || [ $ERROR -eq 7 ]; then
                    continue
                fi
                source helpos.sh
                helpos
                echo 
                echo "Press 'ENTER' or type any key to show menu."
                read BACK OTHER
                if ! [ -z "$OTHER" ]; then
                    echo -e "\e[31mInvalid number of arguments, need '1'.\e[0m" >&2
                    continue
                fi
                if [ -n $BACK ]; then
                    continue
                fi
            ;;
      
            e)
                check_file_exist exitos.sh
                if [ $? -eq 7 ]; then
                    continue
                fi
                check_read exitos.sh
                if [ $? -eq 3 ]; then
                    continue
                fi
                echo "Type back to menu or 'ENTER' to exit with '0' or write a number to exit with it."
                read NUM OTHER
                if ! [ -z "$OTHER" ]; then
                    echo -e "\e[31mInvalid number of arguments, need '1'.\e[0m" >&2
                    continue
                fi
                if [ "$NUM" == "back" ]; then
                    continue
                fi
                source exitos.sh
                if [ -z $NUM ]; then
                    exit 0
                fi
                exitos $NUM "i"
            ;;

            *)
                echo -e "\e[31mDidn't chose a right option. Need to type characters.\e[0m" >&2
            ;;
        esac
    done
}
