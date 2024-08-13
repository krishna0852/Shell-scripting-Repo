#!/bin/bash


# variables 

JAVA_HOME_PATH="/usr/lib/jvm/java-17-openjdk-amd64"
MAVEN_HOME_PATH="/usr/lib/apache-maven-3.9.6"
BIN_PATH="$JAVA_HOME_PATH/bin:$MAVEN_HOME_PATH/bin"
AWSCLI_EKSCTL_KUBECTL_SCRIPT_FILE="https://raw.githubusercontent.com/krishna0852/Shell-scripting-Repo/master/aws-cli-eksctl-kubectl.sh"
MAVEN_LINK="https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz"


# Scirpt should run with root
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run the script with root privileges."
    exit 1
fi

# Set up log file
getdate=$(date +%F)
logfile="Infratools-installation-${getdate}.log"
touch ${logfile}

# Function to validate command status
validateCmndStatus() {
    statusCmnd=$1
    description=$2
    if [ $statusCmnd -ne 0 ]; then
        echo "$description failed. Check the log file for details."
        echo "$description failed." >> $logfile
        exit 1
    else
        echo "$description succeeded."
        echo "$description succeeded." >> $logfile
    fi
}

# Function to update package list and log output
updatePackages() {
    apt-get update -y >> $logfile 2>&1
    validateCmndStatus "$?" "Updating package list"
}

# Update packages
updatePackages

# Install JAVA
echo "Installing Java..."
apt-get install openjdk-17-jdk -y >> $logfile 2>&1
validateCmndStatus "$?" "Java Installation"


#Installing Maven
wget $MAVEN_LINK
validateCmndStatus "$?" "Downloading Maven"
tar -xvf apache-maven-3.9.6-bin.tar.gz
validateCmndStatus "$?" "Extracting Maven"


#moving Maven to usr/lib
mv apache-maven-3.9.6  /usr/lib
validateCmndStatus "$?" ""Moving Maven to usr/lib


#Creating symbolic link for maven 

ln -s  "$MAVEN_HOME_PATH/bin/mvn" mvn



#Setting Environment Variables for Java and Maven

sed -i -e "/^PATH=/ {
    s|^PATH=\"\(.*\)\"|PATH=\"\1:$BIN_PATH\"|
}" /etc/environment

validateCmndStatus "$?" "Setting bin path for Java and maven"

echo "Setting environment variables..."
{
    echo "JAVA_HOME=$JAVA_HOME_PATH"
    echo "MAVEN_HOME=$MAVEN_HOME_PATH"
} >> /etc/environment
validateCmndStatus "$?" "Setting Home path for Java and maven"




#Installing Docker
updatePackages
apt-get install docker.io -y
validateCmndStatus "$?" "Docker Installation"



# Install AWS CLI, eksctl, kubectl from external script
echo "Installing AWS CLI, eksctl, kubectl..."
curl -sL $AWSCLI_EKSCTL_KUBECTL_SCRIPT_FILE  | bash >> $logfile 2>&1
validateCmndStatus "$?" "Installing AWS CLI, eksctl, kubectl"

echo "All installations complete. Check the log file for details: ${logfile}"





