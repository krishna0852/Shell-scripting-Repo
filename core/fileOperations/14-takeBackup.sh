#!/bin/bash

set -e 

trap 'echo "Error at line: $LINENO"' ERR 

echo "Enter a directory with path to take backup"
read dirName 

if [ -z "$dirName" ];then 
     
     echo "Value should not be empty. please enter a valid directory name"
     exit 1
fi


if [ ! -d "$dirName" ]; then 
    
    echo "Given directory $dirName not exists"
    exit 1
fi


NoOfFilesPresent=$(find "$dirName" -type f | wc -l)
backupFolderPath=/d/DevOps-Repositories/shell-scripting/
currentDate=$(date "+%Y-%m-%d-%H:%M:%S")
actualFolderName=$(basename "$dirName")
createBackUpFolder="${backupFolderPath}-${currentDate}-${actualFolderName}"


#for file in "$dirName"/* ; do 
   
#    if [ -f "$file" ]; then 
      
#       echo "moving to bakup folder"

#    fi


# done

if [ "$NoOfFilesPresent" -gt 0 ]; then 
     
     echo "No of files to be backup are: $NoOfFilesPresent"
     echo "Creating backup folder at: $backupFolderPath"
     mkdir "$createBackUpFolder"
     echo "Moving files to backup folder"
    for file in "$dirName"/*; do 

        cp "$file" "$createBackUpFolder/$(basename "$file")"

    done

else 
     echo "No files are present to take backup"
     exit 0
fi
