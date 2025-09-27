#!/bin/bash
yum install fontconfig java-21-openjdk -y
# terraform install
yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum -y install terraform
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y
yum install zip -y

dnf -y install dnf-plugins-core
dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user


curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/refs/heads/main/scripts/get-helm-3
chmod +700 get_helm.sh
./get_helm.sh