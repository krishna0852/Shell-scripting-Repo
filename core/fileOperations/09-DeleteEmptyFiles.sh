#!/bin/bash

set -e

trap 'echo "Error on line $LINENO"' ERR

echo "Enter the directory to delete the empty files in it"

read dirName

if [ -z "$dirName" ]; then 
    
    echo "Value should not be empty. Please enter a value"
    exit 1
fi

if [ ! -d "$dirName" ]; then 
    
    echo "Not a Valid Path"
    exit 1
fi

NoFilesFound=True
NoFilesDeleted=0
for file in "$dirName"/*; do 
   
   if [ -f "$file" ]; then
   
       echo "checking file is empty or not for file:"

       
       
       
    #    checkNoOfLines=$(wc -l $file | awk '{print $1}')

    #    if [ "$checkNoOfLines" -eq 0 ]; then 
            
    #         NoFilesFound=False
    #         echo "found empty file: $file"
    #         rm $file
    #         echo "Empty file deleted: $file"
    #    fi

#==== re-writing the empty file logic using -S flag based on size of the file
    #-s <filename>: This checks if the file exists and is not empty. It evaluates to true if the file size is greater than zero (non-empty), and false if the file size is zero (empty).

       if [ ! -s "$file" ]; then 
          
            NoFilesFound=False
            echo "found empty file: $file"
            rm $file
            echo "Empty file deleted: $file"
            NoFilesDeleted=$(( NoFilesDeleted + 1 ))
       
       fi

   fi

done


if [ "$NoFilesFound" == "True" ]; then 
             
    echo "No empty files found at $dirName to delete"
    exit 0
else 
   
    echo "Total empty files deleted at $dirName are: $NoFilesDeleted"
    exit 0
fi