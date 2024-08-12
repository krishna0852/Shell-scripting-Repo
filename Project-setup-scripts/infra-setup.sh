#!/bin/bash

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
validateCmndStatus "$?" "Java installation"

# Process to install Jenkins

# 1. Import the Jenkins key
echo "Importing Jenkins key..."
wget -O /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key >> $logfile 2>&1
validateCmndStatus "$?" "Importing Jenkins key"

# 2. Add Jenkins repository
echo "Adding Jenkins repository..."
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | tee \
    /etc/apt/sources.list.d/jenkins.list >> $logfile 2>&1
validateCmndStatus "$?" "Adding Jenkins repository"

# 3. Update the package list and install Jenkins
updatePackages

# 4. Install Jenkins
echo "Installing Jenkins..."
apt-get install jenkins -y >> $logfile 2>&1
validateCmndStatus "$?" "Jenkins installation"

# Install make
echo "Installing make..."
apt-get install make -y >> $logfile 2>&1
validateCmndStatus "$?" "Make installation"

# Install Terraform
echo "Installing Terraform..."
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list >> $logfile 2>&1
updatePackages
apt-get install terraform -y >> $logfile 2>&1
validateCmndStatus "$?" "Terraform installation"

# Install yq
echo "Installing yq..."
wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq >> $logfile 2>&1
chmod +x /usr/bin/yq
validateCmndStatus "$?" "Yq installation"

# Update packages again
updatePackages

# Install Ansible
echo "Installing Ansible..."
apt-get install software-properties-common -y >> $logfile 2>&1
validateCmndStatus "$?" "Installing software-properties-common"
add-apt-repository --yes --update ppa:ansible/ansible >> $logfile 2>&1
validateCmndStatus "$?" "Adding Ansible repository"
apt-get install ansible -y >> $logfile 2>&1
validateCmndStatus "$?" "Ansible installation"

# Install boto3 for Python
echo "Installing boto3..."
apt-get install python3-boto3 -y >> $logfile 2>&1
validateCmndStatus "$?" "Boto3 installation"

# Update packages one final time
updatePackages

# Install AWS CLI, eksctl, kubectl from external script
echo "Installing AWS CLI, eksctl, kubectl..."
curl -sL https://raw.githubusercontent.com/krishna0852/Shell-scripting-Repo/master/aws-cli-eksctl-kubectl.sh | bash >> $logfile 2>&1
validateCmndStatus "$?" "Installing AWS CLI, eksctl, kubectl"

echo "All installations complete. Check the log file for details: ${logfile}"
