#!/bin/bash
set -euxo pipefail

sudo echo "=== USER DATA SCRIPT STARTED ===" > /tmp/user_data_check.txt

sudo echo "=== Updating OS Packages ==="
sudo yum update -y

sudo echo "=== Installing core dependencies ==="
sudo yum install -y python3 python3-pip ruby wget unzip

sudo echo "=== Installing Docker ==="
sudo amazon-linux-extras install docker -y
sudo usermod -aG docker ec2-user
sudo systemctl enable docker
sudo systemctl start docker

sudo echo "=== Verifying Docker Installation ==="
if ! command -v docker &> /dev/null; then
  sudo echo "Docker installation failed or not in PATH"
else
  sudo docker --version
fi

sudo echo "=== Installing boto3 ==="
sudo pip3 install boto3

sudo echo "=== Installing CodeDeploy agent ==="
sudo mkdir -p /tmp/codedeploy-install
cd /tmp/codedeploy-install
sudo wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install -O install_codedeploy
sudo chmod +x install_codedeploy
sudo ./install_codedeploy auto

sudo sleep 5
sudo systemctl enable codedeploy-agent
sudo systemctl start codedeploy-agent
sudo systemctl status codedeploy-agent || true

sudo echo "=== User data script completed successfully ==="