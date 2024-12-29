#!/bin/bash

echo "Enter a file to check if it's exist or not" 

read fileName

if [ -z "$fileName" ];then 
    
    echo "Value should not be emply. Please enter a file"
    exit 1
fi

if [ -e "$fileName" ];then 
     
     echo "File exist"
     exit 0
else 
     echo "File doesn't exist"
     exit 0 
fi