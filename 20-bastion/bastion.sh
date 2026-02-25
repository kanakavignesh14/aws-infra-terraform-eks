#!/bin/bash
###############################################################################
# EC2 BOOTSTRAP SCRIPT FOR TERRAFORM, DOCKER & KUBERNETES (EKS)
# OS      : RHEL 9 / Amazon Linux compatible
# Purpose : Prepare server for Terraform, Docker, and EKS operations
###############################################################################

###############################################################################
# STEP 1: EXTEND /HOME FILESYSTEM (FOR TERRAFORM STATE & MODULES)
###############################################################################
growpart /dev/nvme0n1 4
lvextend -L +30G /dev/mapper/RootVG-homeVol
xfs_growfs /home


###############################################################################
# STEP 2: INSTALL TERRAFORM (HASHICORP OFFICIAL REPOSITORY)
###############################################################################
yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum install -y terraform


###############################################################################
# STEP 3: (OPTIONAL) TERRAFORM DATABASE PROVISIONING
# Uncomment if you want automatic DB creation during bootstrap
###############################################################################
# cd /home/ec2-user
# git clone https://github.com/kanakavignesh14/roboshop-dev-infra.git
# chown ec2-user:ec2-user -R roboshop-dev-infra
# cd roboshop-dev-infra/40-databases
# terraform init
# terraform apply -auto-approve


###############################################################################
# STEP 4: INSTALL DOCKER & DOCKER COMPOSE
###############################################################################
dnf -y install dnf-plugins-core
dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


###############################################################################
# STEP 5: ENABLE DOCKER & ADD USER TO DOCKER GROUP
###############################################################################
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user


###############################################################################
# STEP 6: INSTALL KUBECTL (AWS EKS COMPATIBLE VERSION)
###############################################################################
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.34.2/2025-11-13/bin/linux/amd64/kubectl
chmod +x kubectl
mv kubectl /usr/local/bin/kubectl


###############################################################################
# STEP 7: INSTALL EKSCTL (EKS CLUSTER MANAGEMENT TOOL)
###############################################################################
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH
curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_${PLATFORM}.tar.gz"
tar -xzf eksctl_${PLATFORM}.tar.gz -C /tmp
install -m 0755 /tmp/eksctl /usr/local/bin/eksctl
rm -f eksctl_${PLATFORM}.tar.gz /tmp/eksctl


###############################################################################
# STEP 8: INSTALL HELM (KUBERNETES PACKAGE MANAGER)
###############################################################################
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-4
chmod 700 get_helm.sh
./get_helm.sh


###############################################################################
# SCRIPT COMPLETED
###############################################################################