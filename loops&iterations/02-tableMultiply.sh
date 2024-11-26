#!/bin/bash

echo "Enter a Number to print the table"

read number 

if [ -z "$number" ];then 
  
  echo "Entered value should not be empty"
  exit 1
fi 

if [[ "$number" =~ ^[1-9][0-9]*$ ]]; then 
     
     echo "Generating table for $number"

     for (( i=1; i<=10; i++))do 
            
         echo "$number x $i = $(( number * i ))"
     done

else 

    echo "Invalid Input. Enter a positive Number"
    exit 1
fi