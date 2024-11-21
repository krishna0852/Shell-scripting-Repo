#!/bin/bash

echo "Enter Num1 value"

read firstNumber 

echo "Enter Num2 value"

read secondNumber 

echo "Enter Num3 value"

read thirdNumber

largestNumber=$firstNumber

if [[ -z "$firstNumber"  ||  -z "$secondNumber"  ||  -z "$thirdNumber" ]];then 

       echo "Values should not be empty"
       exit 1
fi


if [[ "$firstNumber" =~ ^-?[0-9]+$ && "$secondNumber" =~ ^-?[0-9]+$ && "$thirdNumber" =~ ^-?[0-9]+$ ]];then 
     
     echo "Entered values are numbers"

     # Logic to find largest among three.

       if [ $secondNumber -gt $firstNumber ]; then 
             
             largestNumber="$secondNumber"
             echo "LargestNumber: $largestNumber"
       fi
       
       if [ $thirdNumber -gt $largestNumber ]; then 
             
             largestNumber="$thirdNumber"
             echo "LargestNumber: $largestNumber"
       fi
    
    echo "The largest number is: $largestNumber"

    #    else 
    #         echo "else block"
    #         echo "LargestNumber: $largestNumber"
           
    #    fi

else 
    
    echo "Invalid Input, Values should be Numbers"

fi