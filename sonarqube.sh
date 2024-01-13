#!/bin/bash

chckusr=$(id -u)


if [ $chckusr -ne 0 ]; then
    echo "Please run the script with root privileges"
    exit 1
fi

getdate=$(date +%F)
logfile="sonar-installation-at-${getdate}.txt"
touch ${logfile}

validateCmndStatus() {
    statusCmnd=$1   
    description=$2
    if [ $statusCmnd -ne 0 ]; then
        echo "$description is failure"
        exit 1
    else
        echo "$description is success"
    fi
}

echo "changing directory to /opt folder"
cd /opt
#updating packages
apt-get update -y >> $logfile
validateCmndStatus "$?" "updating packages"

#installing sonar-qube
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.9.10.61524.zip >> $logfile
validateCmndStatus $? "installing sonarqube"

# installing unzip
apt-get install unzip -y >> $logfile
validateCmndStatus $? "installing unzip" 

#unzipping the sonar
unzip sonarqube-9.9.3.79811.zip >> $logfile

validateCmndStatus $? "unzipping the sonarqube"


