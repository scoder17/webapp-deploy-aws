# #!/bin/bash
# set -e

# # Install Python and pip if not already installed
# yum update -y
# yum install -y python3 pip

# # Install Docker
# amazon-linux-extras install docker -y
# systemctl enable docker
# systemctl start docker

# # Install boto3
# pip3 install boto3

# # Write Python script
# cat <<EOF > /root/bootstrap.py
# import subprocess
# import boto3
# import json
# import urllib.request

# def get_instance_metadata():
#     url = \"http://169.254.169.254/latest/dynamic/instance-identity/document\"
#     with urllib.request.urlopen(url) as response:
#         return json.loads(response.read().decode())

# def main():
#     metadata = get_instance_metadata()
#     region = metadata['region']
#     account_id = metadata['accountId']
#     repo = \"devops-app-repo\"  # Adjust if needed

#     # Authenticate to ECR
#     ecr = boto3.client('ecr', region_name=region)
#     token = ecr.get_authorization_token()
#     password = token['authorizationData'][0]['authorizationToken']
#     endpoint = token['authorizationData'][0]['proxyEndpoint']

#     subprocess.run(f\"docker login -u AWS -p {password} {endpoint}\", shell=True, check=True)

#     image = f\"{account_id}.dkr.ecr.{region}.amazonaws.com/{repo}:latest\"
#     subprocess.run(f\"docker pull {image}\", shell=True, check=True)
#     subprocess.run(\"docker stop app || true\", shell=True)
#     subprocess.run(\"docker rm app || true\", shell=True)
#     subprocess.run(f\"docker run -d --name app -p 80:80 {image}\", shell=True, check=True)

# if __name__ == '__main__':
#     main()
# EOF

# # Run Python script
# python3 /root/bootstrap.py





# #!/bin/bash
# set -e

# # Log output to help debug
# exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# echo "=== Updating OS ==="
# yum update -y

# echo "=== Installing core dependencies ==="
# yum install -y python3 pip ruby wget unzip

# echo "=== Installing Docker ==="
# amazon-linux-extras install docker -y
# systemctl enable docker
# systemctl start docker

# echo "=== Adding ec2-user to docker group ==="
# usermod -aG docker ec2-user

# echo "=== Installing boto3 ==="
# pip3 install boto3

# echo "=== Installing CodeDeploy agent ==="
# cd ~
# wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install
# chmod +x ./install
# ./install auto
# systemctl enable codedeploy-agent
# systemctl start codedeploy-agent

# echo "=== Writing bootstrap.py ==="
# cat <<EOF > /root/bootstrap.py
# import subprocess
# import boto3
# import json
# import urllib.request

# def get_instance_metadata():
#     url = "http://169.254.169.254/latest/dynamic/instance-identity/document"
#     with urllib.request.urlopen(url) as response:
#         return json.loads(response.read().decode())

# def main():
#     metadata = get_instance_metadata()
#     region = metadata['region']
#     account_id = metadata['accountId']
#     repo = "devops-app-repo"  # CHANGE if needed

#     ecr = boto3.client('ecr', region_name=region)
#     token = ecr.get_authorization_token()
#     password = token['authorizationData'][0]['authorizationToken']
#     endpoint = token['authorizationData'][0]['proxyEndpoint']

#     subprocess.run(f"docker login -u AWS -p {password} {endpoint}", shell=True, check=True)

#     image = f"{account_id}.dkr.ecr.{region}.amazonaws.com/{repo}:latest"
#     subprocess.run(f"docker pull {image}", shell=True, check=True)
#     subprocess.run("docker stop app || true", shell=True)
#     subprocess.run("docker rm app || true", shell=True)

#     # Run on port 80 for ALB health check
#     subprocess.run(f"docker run -d --name app -p 80:80 {image}", shell=True, check=True)

# if __name__ == '__main__':
#     main()
# EOF

# echo "=== Running bootstrap.py ==="
# python3 /root/bootstrap.py

# echo "=== User data script completed ==="


#!/bin/bash
set -e

# Log output to help debug
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo "=== Updating OS ==="
yum update -y

echo "=== Installing core dependencies ==="
yum install -y python3 pip ruby wget unzip

echo "=== Installing Docker ==="
amazon-linux-extras install docker -y
systemctl enable docker
systemctl start docker

echo "=== Adding ec2-user to docker group ==="
usermod -aG docker ec2-user

echo "=== Installing boto3 ==="
pip3 install boto3

echo "=== Installing CodeDeploy agent ==="
cd ~
wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install
chmod +x ./install
./install auto
systemctl enable codedeploy-agent
systemctl start codedeploy-agent

echo "=== User data script completed - instance prepared for CodeDeploy ==="