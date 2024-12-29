#!/bin/bash
echo "Enter a file name to list the permissions of it"

read fileName

if [ -z "$fileName" ];then 
  
  echo "Value should not be empty"
  exit 1
fi 

if [ -e "$fileName" ];then 
  
    
      filePermissions=$(ls -l "$fileName" | awk '{print $1F}')
      echo "Ginve File Permissions are: $filePermissions"

else 
     echo "File doesn't exist"
     exit 0
fi