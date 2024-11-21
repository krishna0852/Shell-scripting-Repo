#!/bin/bash 

echo "Enter a Number to check even or odd"

read number

if  [ -z "$number" ]; then #check if entered value is empty or not

      echo "Value should not be empty. Please enter a Number"
      exit 1
fi

if [[ "$number" =~ ^-?[0-9]+$ ]]; then  #check if entered value is number
        echo "Entered Value is a Number"
        if [ $((number %2)) -eq 0 ]; then 
            echo "Entered Number $number is even"
        else 
           echo "Entered Number $number is odd"
        fi
    else 
       echo "Entered Value should be a Number. Please enter a Number"
fi
 