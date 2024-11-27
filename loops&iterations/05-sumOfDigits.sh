#!/bin/bash

echo "Enter a Number to find it's sum of digits"

read number

cloneNumber=$number
sum=0
if [ -z "$number" ];then 
   
   echo "Input should not be empty"
   exit 1

fi

if [[ $number =~ ^[1-9][0-9]*$ ]];then 
     
     echo "finding Sum of digits for number: $number"

     while [ "$number" -gt 0 ]; do 
           
           #echo "Inloop"
           sum=$((sum + number % 10))
           number=$((number / 10))
     done 
     
     echo "The sum of digits of $cloneNumber is $sum"

else 

    echo "Invalid Input. Enter a positive Number"
    exit 1
fi


