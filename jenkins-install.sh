#!/bin/bash

chckusr=$(id -u)


if [ $chckusr -ne 0 ]; then
    echo "Please run the script with root privileges"
    exit 1
fi

getdate=$(date +%F)
logfile="jenkins-installation-at-${getdate}.txt"
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

# Update packages
apt-get update -y >> $logfile
validateCmndStatus "$?" "updating packages"

# Install JAVA
apt-get install openjdk-17-jdk -y >> $logfile
# Check if Java installation was successful or not
validateCmndStatus "$?" "java installation"

# Process to install Jenkins

# 1. Import the key
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key >> $logfile
validateCmndStatus "$?" "importing key"

# 2. Add Jenkins repository
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null >> $logfile
validateCmndStatus "$?" "adding jenkins repository"

# 3. Update the packages and install Jenkins
apt-get update -y >> $logfile
validateCmndStatus "$?" "updating packages"

# 4. Install Jenkins
apt-get install jenkins -y >> $logfile
validateCmndStatus "$?" "installing jenkins"