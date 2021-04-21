#!/usr/bin/env bash

helpos()
{
    echo

    echo "MAIN"
    echo "  ./main.sh [OPTION...] [?...]"
    echo "  ? - see options below."
    echo 
    echo "OPTIONS:"    
    echo    
    echo "CALCULATOR"
    echo "  ./main.sh calc [ACTION...] [NUM1...] [NUM2...]"
    echo "  Actions: sum, sub, div, mul. Num1 and Num2: only on integers."
    echo
    echo "SEARCH"
    echo "  ./main.sh search [DIR...] [REG...]"
    echo "  Search: search a regular expression in this directory. Regular expression: write it."
    echo
    echo "REVERSE"    
    echo "  ./main.sh reverse [FILE1...] [FILE2...]"   
    echo "  Reverse: reverse all from file1 to file2."   
    echo    
    echo "STRLENGHT"    
    echo "  ./main.sh strlen [STRING...]"   
    echo "  Strlenght: lenght of the string"   
    echo    
    echo "LOG"   
    echo "  ./main.sh log"
    echo "  Log: get the nice log from \"/var/log/anaconda/X.log\"."    
    echo
    echo "INTERACTIVE"
    echo "  ./main.sh interactive"
    echo "  Interactive: interactive mode with menu." 
    echo
    echo "HELP"
    echo "  ./main.sh help"
    echo "  Get help."
    echo
    echo "EXIT"
    echo "  ./main.sh exit [NUM...]"  
    echo "  Exit: exit from app with your code(by default \"0\")"   
    echo 
    echo    
    echo "ERRORS"
    echo "  Main errors: 1 - didn't chose an option after \"main.sh\", 2 - invalid number of arguments, 3 - don't have permissions to read, 4 - don't have permissions to write, 5 - don't have permissions to execute file, 6 - can't find some directory, 7 - can't find some file."
    echo
    echo "  Calculator errors: 11 - chose a wrong action, 12 - calculator works only with integers, 13 - division by zero."
    echo
    echo "  Exit errors: 1001 - need number from 0 to 255."
    
    echo 
}
