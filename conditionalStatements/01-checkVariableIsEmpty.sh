#!/bin/bash

if [ -z "$1" ]; then 
  echo "usage: $0 <yourname>"
else 
  echo "Hi $1, Welcome to ShellScript"
fi

userName=$1

echo "Entered UserName: $userName"


#In shell scripting, the -z option is used with the test command (or [ in a conditional statement) to check if a string is empty.