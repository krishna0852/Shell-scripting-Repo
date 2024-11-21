#!/bin/bash

echo "Enter a Number"

read number

if [[ "$number" =~ ^-?[0-9]+$ ]]; then 
   echo "yes, it's a number"
else 
  echo "no, it's not a number"
fi