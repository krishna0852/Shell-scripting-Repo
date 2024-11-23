#!/bin/bash 

echo "Enter a year to check leap year or not"

read checkYear

if [ -z "$checkYear" ];then
     
     echo "Entered Value should not be empty. Please enter a year."
     exit 1
fi  

if [[ $checkYear =~ ^-?[0-9]+$ ]]; then 

      echo "Entered value is valid number"

      #check leap year
      #if (( (checkYear % 4 == 0 && checkYear % 100 != 0) || (checkYear % 400 == 0) )); then # we can also use this format in bash


      if [[ ($((checkYear % 4 )) -eq 0 && $((checkYear % 100 )) -ne 0) || $((checkYear % 400 )) -eq 0 ]]; then 

         echo "Entered Year $checkYear is a Leap year."
      else 
        
         echo "Entered Year $checkYear is not a Leap year."
      fi

else 

    echo "Entered Value should be a Number. Please Enter a Year"
fi