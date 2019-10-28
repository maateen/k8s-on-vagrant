#!/usr/bin/env bash

# Doing pre-flight works
sed -i 's|http://archive|http://bd.archive|g' /etc/apt/sources.list

# Install dependencies
apt-get update && apt-get install -y apt-transport-https ca-certificates curl software-properties-common

### Add Docker’s official repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"

## Install Docker CE.
apt-get update && apt-get install -y docker-ce=18.06.2~ce~3-0~ubuntu

# Setup daemon.
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

mkdir -p /etc/systemd/system/docker.service.d

# Restart docker.service
systemctl daemon-reload
systemctl restart docker
systemctl enable docker.service

# Add K8S official repository
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update

# Install K8S
apt-get install -y kubelet kubeadm kubectl

# kubelet requires swap off
swapoff -a
# keep swap off after reboot
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Get the IP address of this VM
IPADDR=`ifconfig eth1 | grep -i Mask | awk '{print $2}'| cut -f2 -d:`
echo This VM has IP address $IPADDR

# Set up Kubernetes
NODENAME=$(hostname -s)
kubeadm init --apiserver-advertise-address $IPADDR  --node-name $NODENAME --pod-network-cidr=10.244.0.0/16

# Set up admin creds for the vagrant user
echo Copying credentials to /home/vagrant...
mkdir -p /home/vagrant/.kube
cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown $(id -u vagrant):$(id -g vagrant) /home/vagrant/.kube/config