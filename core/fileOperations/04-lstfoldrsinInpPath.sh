#!/bin/bash

echo "Enter the path to list the directories:"

read dirPath

if [ -z "$dirPath" ]; then 
    
    echo "value should not be empty. Please enter directory path"
    exit 1
fi

if [ ! -d "$dirPath" ]; then 
    
    echo "Given Directory not exist in system. Please enter correct Path"
    exit 1
fi

isDirExist=false

for dir in "$dirPath"/*; do 
    
    if [ -d "$dir" ]; then 
        
        echo "$dir"
        isDirExist=true
    fi
done 

if [ "$isDirExist" == "false" ];then 
     
     echo "No directroies exist in given path: $dirPath"
     exit 0
fi