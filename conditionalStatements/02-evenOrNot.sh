#!/bin/bash

echo "Enter a number to check even or odd"

read number 

if [ -z "$number" ]; then 
   echo "value should not be an empty. Please enter a number"
else 
   if [ $((number % 2)) -eq 0 ]; then 
      echo "$number is even"
   else
     echo "$number is odd"
   fi
fi