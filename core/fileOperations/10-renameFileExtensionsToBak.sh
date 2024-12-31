#!/bin/bash 

set -e 

trap 'echo "Error at Line: $LINENO"' ERR

echo "Enter a directory to rename all .txt files to .bak"

read dirName


if [ -z "$dirName" ];then 
   
   echo "Value should not be empty. Please enter the directory name"
   exit 1
fi


if [ ! -d "$dirName" ]; then 
   
   echo "Not a valid path"
   exit 1

fi

NoOfTxtfilesFound=0
NoTxtFiles=True

for file in "$dirName"/*.txt; do 
     
     if [ -f "$file" ]; then 
        
        echo "Found file with txt extension: $file"
        NoTxtFiles=False
        newFileName="${file%.txt}.bak"
        mv $file $newFileName
        echo "filename renamed from $file to $newFileName"
        NoOfTxtfilesFound=$(( NoOfTxtfilesFound + 1 ))

     fi
done

if [ "$NoTxtFiles" == "True" ]; then 
   
   echo "No txt files found at $dirName"
   exit 0

else 
   
   echo "Total no of files renamed at $dirName are: $NoOfTxtfilesFound"
   exit 0
fi

