#!/bin/bash

echo "Give the filename with path to count it's words, characters, lines"
read readFile

if [ -z "$readFile" ]; then 
      echo "Value should not be empty. please enter a filename with path"
      exit 1
fi

if [ ! -e $readFile ]; then 
     
     echo "The given path doesn't exist. please enter correct path."
     exit 1
fi

noOfLines=$(wc -l $readFile | awk '{print $1F}')
noOfCharacters=$(wc -c $readFile | awk '{print $1F}')
noOfWords=$(wc -w $readFile | awk '{print $1F}')

echo "Number of lines in given file: $noOfLines "
echo "Number of characters in given file: $noOfCharacters"
echo "Number of words in given file: $noOfWords "

