#!/bin/bash 

getid=$(id -u)

if [ $getid -ne 0 ];
then 
echo "please run this script with root access"
fi

apt-get update -y 

if [ $? -ne 0 ];
then 
echo "failed to update packages, pls try again"
exit 1
fi

apt-get install net-tools -y 

if [ $? -ne 0 ];
then 
echo "failed to install net-tools, please check"
exit 1 

else
echo "net-tools is installed now"
exit 0
fi

