#!/bin/bash

chckusr=$(id -u)


if [ $chckusr -ne 0 ]; then
    echo "Please run the script with root privileges"
    exit 1
fi


getdate=$(date +%F)
logfile="sonar-installation-at-${getdate}.log"
touch ${logfile}

# storing a default username and password in username and password variables
username=sonar
password=runsonar

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
unzip sonarqube-8.9.10.61524.zip >> $logfile

validateCmndStatus $? "unzipping the sonarqube"

echo "renaming from sonarqube-8.9.10.61524 -> sonar"

installation_directory=sonarqube-8.9.10.61524
changingTo=sonar 

mv  $installation_directory $changingTo
validateCmndStatus $? "renaming from sonarqube-8.9.10.61524 -> sonar"

echo "sonarqube cannot run as root user, creating a user for sonar"

useradd -m -s /bin/bash "$username"
#adduser $username

validateCmndStatus $? "creating user $username"

echo $username:$password | chpasswd

validateCmndStatus $? "setting password for user $username"

echo "setting ownership permisisons to user $user for sonar directory"

chown $username:$username $changingTo

validateCmndStatus $? "setting ownership permissions"

echo "starting sonarqube with user $username"

echo "moving to bin directory to start"

cd /sonar/bin/linux-x86-64

validateCmndStatus $? "moving to bin directory"

echo "starting sonarqube"

sh sonar.sh run 

validateCmndStatus $? "starting sonarqube"

echo "sonarqube current status" 

sh sonar.sh status 