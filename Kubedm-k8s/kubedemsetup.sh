#!bin/bash

checkUserIsRoot=$(id -u)
installedDate=$(date +%F)
KubedmLogFile="Kubedm_setup_on-${installedDate}.log"

## ================Mention version numbers =======================
containerdVersion="1.7.13"
RuncVersion="1.1.12"
CNIVersion="1.4.0"
## =================================================================

if [ "$checkUserIsRoot" -ne 0 ]; then 
  echo "Script executed by non-root user, Please execute script with root access" 
  exit 1
fi

validateCmndStatus(){

    cmndstatus=$1
    description=$2
   
    if [ "$cmndstatus" -ne 0 ]; then 
       echo "$description is failure, please check logs"
       exit 1
    else 
      echo "$description is success"
    fi
      
}


updatePackages(){
    
    echo "Updating packages"
    apt-get update -y >> $KubedmLogFile 2>&1
    validateCmndStatus "$?" "updating packages"
}

updatePackages
<<comment
echo "Updating packages ..."
apt-get update -y 
validateCmndStatus "$?" "updating packages"
comment

#configuration starts

echo "Disabling swap to work kublet properly"
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab >> $KubedmLogFile 2>&1
validateCmndStatus "$?" "disabling swap"


#==========================Containerd installation start================================

echo "Installing containerd"

wget https://github.com/containerd/containerd/releases/download/v1.7.13/containerd-1.7.13-linux-amd64.tar.gz >> $KubedmLogFile 2>&1
tar Cxzvf /usr/local containerd-1.7.13-linux-amd64.tar.gz >> $KubedmLogFile 2>&1
wget https://raw.githubusercontent.com/containerd/containerd/main/containerd.service >> $KubedmLogFile 2>&1
mkdir -p /usr/local/lib/systemd/system >> $KubedmLogFile 2>&1
mv containerd.service /usr/local/lib/systemd/system/containerd.service >> $KubedmLogFile 2>&1
systemctl daemon-reload >> $KubedmLogFile 2>&1
systemctl enable --now containerd >> $KubedmLogFile 2>&1

validateCmndStatus "$?" "installing containerd"

#==========================Containerd installation end================================


#==========================Runc installation start================================

echo "Installing Runc"
wget https://github.com/opencontainers/runc/releases/download/v1.1.12/runc.amd64 >> $KubedmLogFile 2>&1
install -m 755 runc.amd64 /usr/local/sbin/runc >> $KubedmLogFile 2>&1

validateCmndStatus "$?" "installing Runc"

echo "Installing CNI"
wget https://github.com/containernetworking/plugins/releases/download/v1.4.0/cni-plugins-linux-amd64-v1.4.0.tgz >> $KubedmLogFile 2>&1
mkdir -p /opt/cni/bin >> $KubedmLogFile 2>&1
tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.4.0.tgz >> $KubedmLogFile 2>&1
validateCmndStatus "$?" "installing CNI"

#==========================Runc installation end================================



#==========================CRICTL installation start================================

echo "Installing CRICTL"
VERSION="v1.29.0" # check latest version in /releases page
wget https://github.com/kubernetes-sigs/cri-tools/releases/download/$VERSION/crictl-$VERSION-linux-amd64.tar.gz >> $KubedmLogFile 2>&1
tar zxvf crictl-$VERSION-linux-amd64.tar.gz -C /usr/local/bin >> $KubedmLogFile 2>&1
rm -f crictl-$VERSION-linux-amd64.tar.gz >> $KubedmLogFile 2>&1

cat <<EOF | sudo tee /etc/crictl.yaml
runtime-endpoint: unix:///run/containerd/containerd.sock
image-endpoint: unix:///run/containerd/containerd.sock
timeout: 2
debug: false
pull-image-on-create: false
EOF >> $KubedmLogFile 2>&1

validateCmndStatus "$?" "Installing CRICTL"

#==========================CRICTL installation end ================================



#==========================Kubernetes setup and installation start================================

echo "Configuration for Kubernetes setup"

updatePackages

<<comment 
echo "Updating packages ..."

apt-get update -y 
validateCmndStatus "$?" "updating packages"
comment

echo "Installing packages needed to use the Kubernetes apt repository"

apt-get install -y apt-transport-https ca-certificates curl gpg >> $KubedmLogFile 2>&1

validateCmndStatus "$?" "Installing packages for kubernetes apt repository"

echo "In releases older than Debian 12 and Ubuntu 22.04, directory /etc/apt/keyrings does not exist by default, and it should be created before the curl command."

echo "Creating directory keyrings in /etc/apt" 

mkdir -p -m 755 /etc/apt/keyrings >> $KubedmLogFile 2>&1
validateCmndStatus "$?" "Creating directory"

echo "Downloading the public signing key for the Kubernetes package repositories. Same signing key is used for all repositories disregard the version"

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg >> $KubedmLogFile 2>&1

validateCmndStatus "$?" "Downloading the public signing key for the Kubernetes package"

echo "Add the appropriate Kubernetes apt repository."
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list >> $KubedmLogFile 2>&1
validateCmndStatus "$?" "Adding the appropriate Kubernetes apt repository"

updatePackages

<<comment
echo "Updating packages ..."
apt-get update -y
validateCmndStatus "$?" "updating packages"
comment

echo "Installing kubelet, Kubeadm, kubectl"
apt-get install -y kubelet kubeadm kubectl >> $KubedmLogFile 2>&1
validateCmndStatus "$?" "Installing kubelet, Kubeadm, kubectl"

apt-mark hold kubelet kubeadm kubectl >> $KubedmLogFile 2>&1
#==========================Kubernetes setup and installation end================================

















