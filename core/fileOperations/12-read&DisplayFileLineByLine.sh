#!/bin/bash

set -e
trap 'echo "Error at line no: $LINENO"' ERR

echo "Enter a filename to display line by line contents"

read fileName

if [ -z "$fileName" ];then 
    
    echo "Filename should not be empty. Please enter a filename"
    exit 1
fi


if [ ! -e "$fileName" ];then 
    
    echo "Given File not exists."
    exit 1
fi


if [ -f "$fileName" ];then 
    
    echo "it's a file"

    while read -r line; do 
        echo "$line"
    done <"$fileName"
fi