#!/bin/bash 

echo "Enter a String Value"

read strValue

if [[ "$strValue" =~ ^[a-zA-z]+$ ]]; then
     echo "it's a string value"
else 
     echo "it's not a string value"
fi
   