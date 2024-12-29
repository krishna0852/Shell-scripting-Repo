#!/bin/bash 

#echo "moving to $1"

if [ -z $1 ]; then 
     
     echo "Path required to list the files. Provide the path"
     exit 1
fi

if [ ! -d $1 ]; then 
   
   echo "it's not a valid directory path"
   exit 1
fi

echo "Listing files at path: $1"

path=$1

for file in "$path"/*; do 
   
   if [ -f "$file" ]; then 
         echo "$file"
  fi
done 
