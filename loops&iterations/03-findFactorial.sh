#!/bin/bash 

echo "Enter a Number to find factorial for a given number."

read factNum

if [ -z "$factNum" ]; then 
     
     echo "Entered Value should not be empty."
     exit 1
fi


if [[ "$factNum" =~ ^[1-9][0-9]*$ ]]; then 
     
     echo "Generating Factorial for number: $factNum"

    #  while factNum>0; do
          
    #       factorialValue=$factNum 
    #       factNum=$(( factNum -1 ))
    #       value=factNum
          
          
    #  done

    factVal=1

    for (( i = 1; i <= factNum; i++ )) do 
            
            factVal=$((factVal * i))
             
            
    done
    
    echo "$factVal"

else 
     
     echo "Invalid Input. Please enter a positive Number."
     exit 1
fi
