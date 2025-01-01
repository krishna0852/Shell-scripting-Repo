#!/bin/bash

set -e

trap 'echo "Error at line: $LINENO"' ERR 

echo "Enter a directory to count no of files in it"

read dirName

if [ -z "$dirName" ]; then 
    
    echo "Value should not be empty. please enter a valid directory with path"
    exit 1
fi

if [ ! -d "$dirName" ]; then 

    echo "Not a valid path"
    exit 1
fi

fileCount=0

for file in "$dirName"/* ; do 
    
    if [ -f "$file" ]; then 
            echo "$file"
            fileCount=$(( fileCount + 1 ))

    fi 
done 


if [ "$fileCount" -gt 0 ];then
     
     echo "No of files in $dirName are: $fileCount"
     exit 0

else 

     echo "No files found in $dirName"
     exit 0
fi