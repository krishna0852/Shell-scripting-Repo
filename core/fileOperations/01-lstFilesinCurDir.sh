#!/bin/bash

echo "Listing all the files in the current directory"

for files in *; do 
  
  if [ -f $files ]; then 
       
       echo $files
  fi 
done 