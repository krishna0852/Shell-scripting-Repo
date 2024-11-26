#!/bin/bash

echo "Enter a Number to print natural Numbers"

read number

if [ -z "$number" ]; then 
    
    echo "Entered Value should not be empty"
    exit 1
fi

if [[ "$number" =~ ^[1-9][0-9]*$ ]]; then
    
    echo "Entered Value is a valid Number. $number"

    # actual logic to print N natural numbers for a given number.

     echo "Natural Numbers are up to $number" 
     for (( i=1; i<=number; i++ )) do 
               
            echo "$i"
     done

else 

    echo "Invalid Input. Please enter a positive number"
fi