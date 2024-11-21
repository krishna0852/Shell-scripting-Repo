#!/bin/bash

echo "Enter Num1 value"

read  firstNumber

echo "Enter Num2 valie"

read secondNumber 

echo "Enter Num3 value"

read thirdNumber 

echo "Enter Num4 value"

read fourthNumber

if [[ -z "$firstNumber" || -z "$secondNumber" || -z "$thirdNumber" || -z "$fourthNumber" ]]; then 
     
     echo "Values should not be empty"
     exit 1
fi


if [[ "$firstNumber" =~ ^-?[0-9]+$ && "$secondNumber" =~ ^-?[0-9]+$ && "$thirdNumber" =~ ^-?[0-9]+$ && "$fourthNumber" =~ ^-?[0-9]+$ ]]; then 
       
       echo "Entered Values are Numbers"

       largestNumber="$firstNumber"

       if [ $secondNumber -gt $firstNumber ];then 

            largestNumber=$secondNumber
       fi

       if [ $thirdNumber -gt $largestNumber ];then 
           
           largestNumber=$thirdNumber
       fi

       if [ $fourthNumber -gt $largestNumber ];then 
           largestNumber=$fourthNumber
       fi
    
    echo "The largest Number is: $largestNumber"
else 
   
   echo "Invalid Input, Enter a Number"
fi
