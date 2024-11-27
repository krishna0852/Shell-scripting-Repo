#!/bin/bash

echo "Enter a Number to check it's prime or not"

read number
isPrime=0

if [ -z "$number" ]; then 
    
    echo "Entered Value should not be empty"
    exit 1
fi

if [[ "$number" =~ ^[1-9][0-9]*$ ]];then 
 
      echo "Checking for number. $number"

      if [ $number -eq 1 ];then 
          
          echo "$number is neither composite nor prime"
          exit 0
      fi

      for (( i = 1; i <= number/2; i++ )); do 

            if [[ $((number % i )) -eq 0 ]]; then 

                    isPrime=$(( isPrime + 1 )) 
            fi
                 
      done
      
      echo "isPrime value: $isPrime" 

      if [ "$isPrime" -eq 2 ]; then 

           echo "$number is a prime number"
      else 

            echo "$number is  not a prime number"
      fi
      

else 

    echo "Invalid Input. Please enter a positive number"
    exit 1
fi 