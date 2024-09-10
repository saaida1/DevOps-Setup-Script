#!/bin/bash

# Update and Upgrade System Packages
echo "--------------------Updating and Upgrading System Packages--------------------"
sudo apt-get update -y
sudo apt-get upgrade -y

# Install Java Development Kit (JDK)
echo "--------------------Installing Java Development Kit (JDK)--------------------"
sudo apt-get install openjdk-17-jre -y

# Install Python 3.8
echo "--------------------Installing Python 3.8--------------------"
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt-get update -y
sudo apt-get install python3.8 -y

# Install Python Package Installer (pip)
echo "--------------------Installing Python Package Installer (pip)--------------------"
sudo apt-get install python3-pip -y

# Install Jenkins
echo "--------------------Installing Jenkins--------------------"
# Add Jenkins GPG key
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

# Add Jenkins apt repository
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package index and install Jenkins
sudo apt-get update -y
sudo apt-get install jenkins -y

# Start and enable Jenkins service
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Install Docker
echo "--------------------Installing Docker--------------------"
sudo apt-get remove -y docker docker-engine docker.io containerd runc
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

# Install Ansible
echo "--------------------Installing Ansible--------------------"
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:ansible/ansible -y
sudo apt-get update -y
sudo apt-get install ansible -y

# Install Docker Compose
echo "--------------------Installing Docker Compose--------------------"
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
sudo chmod 666 /var/run/docker.sock

# Install AWS Command Line Interface (CLI)
echo "--------------------Installing AWS Command Line Interface (CLI)--------------------"
sudo apt-get install zip -y
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip
sudo ./aws/install

# Install eksctl
echo "--------------------Installing eksctl--------------------"
sudo curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

# Install kubectl
echo "--------------------Installing kubectl--------------------"
sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(<kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install Minikube
echo "--------------------Installing Minikube--------------------"
sudo curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube start

# Install K9s
echo "--------------------Installing K9s--------------------"
wget https://github.com/derailed/k9s/releases/download/v0.25.18/k9s_Linux_x86_64.tar.gz
sudo tar -xvzf k9s_Linux_x86_64.tar.gz
sudo install -m 755 k9s /usr/local/bin

# Add Docker to sudo Group
echo "--------------------Adding Docker to Sudo Group--------------------"
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
sudo chmod 777 /var/run/docker.sock

# Install Terraform
echo "--------------------Installing Terraform--------------------"
sudo curl -LO "https://releases.hashicorp.com/terraform/1.5.0/terraform_1.5.0_linux_amd64.zip"
sudo unzip terraform_1.5.0_linux_amd64.zip -d /usr/local/bin
sudo chmod +x /usr/local/bin/terraform

# Display Jenkins Initial Admin Password
echo "--------------------Jenkins Initial Admin Password--------------------"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
