#!/bin/bash

# Variables
JAVA_HOME_PATH="/usr/lib/jvm/java-17-openjdk-amd64"
MAVEN_HOME_PATH="/usr/lib/apache-maven-3.9.6"
BIN_PATH="$JAVA_HOME_PATH/bin:$MAVEN_HOME_PATH/bin"
AWSCLI_EKSCTL_KUBECTL_SCRIPT_FILE="https://raw.githubusercontent.com/krishna0852/Shell-scripting-Repo/master/aws-cli-eksctl-kubectl.sh"
MAVEN_LINK="https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz"
MAVEN_TAR="apache-maven-3.9.6-bin.tar.gz"

# Script should run with root
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run the script with root privileges."
    exit 1
fi

# Set up log file
getdate=$(date +%F)
logfile="Infratools-installation-${getdate}.log"
touch "${logfile}"

# Function to validate command status
validateCmndStatus() {
    statusCmnd=$1
    description=$2
    if [ "$statusCmnd" -ne 0 ]; then
        echo "$description failed. Check the log file for details."
        echo "$description failed." >> "${logfile}"
        exit 1
    else
        echo "$description succeeded."
        echo "$description succeeded." >> "${logfile}"
    fi
}

# Function to update package list and log output
updatePackages() {
    apt-get update -y >> "${logfile}" 2>&1
    validateCmndStatus "$?" "Updating package list"
}

# Check if Java is already installed
if ! java -version &>/dev/null; then
    echo "Installing Java..."
    apt-get install openjdk-17-jdk -y >> "${logfile}" 2>&1
    validateCmndStatus "$?" "Java Installation"
else
    echo "Java is already installed."
fi

# Check if Maven is already installed
if [ ! -d "$MAVEN_HOME_PATH" ]; then
    echo "Installing Maven..."
    wget "$MAVEN_LINK" >> "${logfile}" 2>&1
    validateCmndStatus "$?" "Downloading Maven"
    tar -xvf "$MAVEN_TAR" >> "${logfile}" 2>&1
    validateCmndStatus "$?" "Extracting Maven"
    mv apache-maven-3.9.6 /usr/lib >> "${logfile}" 2>&1
    validateCmndStatus "$?" "Moving Maven to /usr/lib"
    ln -sf "$MAVEN_HOME_PATH/bin/mvn" /usr/bin/mvn >> "${logfile}" 2>&1
    validateCmndStatus "$?" "Creating symlink for mvn"
else
    echo "Maven is already installed."
fi

# Setting Environment Variables for Java and Maven
echo "Setting environment variables..."
if ! grep -q "JAVA_HOME" /etc/environment; then
    {
        echo "JAVA_HOME=$JAVA_HOME_PATH"
        echo "MAVEN_HOME=$MAVEN_HOME_PATH"
    } >> /etc/environment
    validateCmndStatus "$?" "Setting JAVA_HOME and MAVEN_HOME"
fi

# Update PATH in /etc/environment if not present
if ! grep -q "$BIN_PATH" /etc/environment; then
    sed -i -e "/^PATH=/ {
        s|^PATH=\"\(.*\)\"|PATH=\"\1:$BIN_PATH\"|
    }" /etc/environment
    validateCmndStatus "$?" "Setting PATH for Java and Maven"
fi

# Install Docker
if ! command -v docker &> /dev/null; then
    echo "Installing Docker..."
    updatePackages
    apt-get install docker.io -y >> "${logfile}" 2>&1
    validateCmndStatus "$?" "Docker Installation"
else
    echo "Docker is already installed."
fi

# Install AWS CLI, eksctl, kubectl from external script
echo "Installing AWS CLI, eksctl, kubectl..."
curl -sL "$AWSCLI_EKSCTL_KUBECTL_SCRIPT_FILE" | bash >> "${logfile}" 2>&1
validateCmndStatus "$?" "Installing AWS CLI, eksctl, kubectl"

echo "All installations complete. Check the log file for details: ${logfile}"
