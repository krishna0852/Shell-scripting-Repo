#!/bin/bash 
getid=$(id -u)

if [ $getid -ne 0 ];
  then
  echo "please run the script with root privileages"
  exit 1
fi 

getdate=$(date +%F)

logfile="AEK-installation-on-$getdate.log"

touch $logfile

awscli="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
eksctl="https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" 
kubectl_version=1.27.9
kubectl="https://s3.us-west-2.amazonaws.com/amazon-eks/$kubectl_version/2024-01-04/bin/linux/amd64/kubectl"

validateCmndStatus(){
cmndsts=$1
description=$2
if [ $cmndsts -ne 0 ]; then 
  echo  "$description failure"
  exit 1
else 
  echo "$description success"
fi

}

apt-get update -y >> $logfile

validateCmndStatus $? "updating packages is "

echo "installing unzip"

apt-get install unzip -y  >> $logfile

validateCmndStatus $? "installing unzip is "

echo "installing aws cli"

curl $awscli -o "awscliv2.zip"  >> $logfile

validateCmndStatus $? "importing aws cli file using curl"
#-o to -over-write
unzip -o awscliv2.zip >> $logfile

validateCmndStatus $? "unzipping awscli is" 

echo "install in the newly unzipped aws directory. By default, the files are all installed to /usr/local/aws-cli, and a symbolic link is created in /usr/local/bin"
 
 #--update 
 ./aws/install --update >> $logfile

validateCmndStatus $? "creating symbolic link is "

echo "awscli-installed, checking aws cli version"

aws_cli_version=$(aws --version) 

validateCmndStatus $? " version $aws_cli_version is "

echo "awscli successfully installed, proceeding to install eksctl"

curl --silent --location $eksctl | tar xz -C /tmp >> $logfile

validateCmndStatus $? "installing latest version of eksctl using curl is"

echo "Move the extracted binary to /usr/local/bin."

mv /tmp/eksctl /usr/local/bin 

validateCmndStatus $? "extracting to binary to bin is "

echo "checking the eksctl version"

eksctl_version=$(eksctl version)

validateCmndStatus $? "version $eksctl_version is "

echo "eksctl installed successfully, proceeding to install kubectl with $kubectl_version "

curl -O $kubectl >> $logfile

validateCmndStatus $? "installing kubectl binaries is "

echo "Applying execute permissions to the binary."

chmod +x ./kubectl

validateCmndStatus $? "applying execute permission is "

echo "Copy the binary to a folder in your PATH."

mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH

validateCmndStatus $? "copying binary is "

echo "kubectl installed, checking kubectl version"

installed_kubectl_version=$(kubectl version)

validateCmndStatus $? "version $installed_kubectl_version"

echo "=====AWSCLI, EKSCTL, KUBECTL INSTALLED SUCCESSFULLY=="

echo "configure aws credentials and launch eks cluster"
exit 0







