#/bin/bash

chkusr=$(id -u)

if [ $chkusr -ne 0 ]; then
echo "please run this script with root privleages"
exit 1
fi
getdate=$(date +%F)
logfile="docker-installation-at-${getdate}"

touch $logfile

validateCmndStatus() {
    statusCmnd=$1
    description=$2
    if [ $statusCmnd -ne 0 ];then
    echo "$description is fail"
    exit 1
    else
    echo "$description is success"
    fi
}

#updating packages
apt-get update -y >> $logfile

validateCmndStatus $? "updating packages"

#installing docker
apt-get install docker.io -y >> $logfile

validateCmndStatus $? "installing docker"

#checking docker version
getVersion=$(docker --version)

validateCmndStatus $? "docker version ${getVersion} installed"