#!/bin/bash

set -e

trap 'echo "Error on line $LINENO"' ERR

echo "Enter a directory with path to count words,lines,characters in it's files"

read dirName

if [ -z "$dirName" ]; then
    
    echo "Value should not be empty. Please enter the directory with path"
    exit 1 
fi

if [ ! -d "$dirName" ]; then
   
   echo "Not a valid path"
   exit 1

fi


for file in "$dirName"/*; do
    
    if [ -f "$file" ]; then 
        
        noOfLines=$(wc -l $file | awk '{print $1F}')
        noOfCharacters=$(wc -c $file | awk '{print $1F}')
        noOfWords=$(wc -w $file | awk '{print $1F}')
        
        echo "Filename: $file"
        echo " No of lines: $noOfLines"
        echo " No of characters: $noOfCharacters"
        echo " No of words: $noOfWords"
    fi
   
done 