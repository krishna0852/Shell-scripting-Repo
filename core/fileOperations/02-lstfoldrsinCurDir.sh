#!/bin/bash 

echo "Listing all files in current Directory"

for folder in *; do 
   if [ -d "$folder" ];then 
       
       echo "$folder"
   fi 
done