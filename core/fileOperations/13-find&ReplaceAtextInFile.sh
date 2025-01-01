#!/bin/bash 

set -e 
trap 'echo "Error at line: $LINENO"' ERR 

echo "Enter  a filename to replace a text"

read fileName 

echo "Enter actual text to replace"

read actualText

echo "Enter replace text"

read replaceText

if [[ -z "$fileName" || -z "$actualText" || -z "$replaceText" ]];then 
    
    echo "Values shoud not be empty"
    exit  1
fi

if [ ! -e "$fileName" ]; then 
   
   echo "File not exits"
   exit 1

fi

if [ -f "$fileName" ]; then 

   if grep -q "$actualText" "$fileName" ; then
    
    echo "$actualText found and replacing:  $actualText -> $replaceText"

    sed -i "s/$actualText/$replaceText/g" $fileName 

    echo "Replaced successfully."

  else 
    
    echo "$actualText is not found in $fileName file"
    exit 0
  
  fi
fi