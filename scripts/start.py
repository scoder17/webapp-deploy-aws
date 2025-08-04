#!/usr/bin/env python3
import subprocess
import os
import json
import urllib.request

REGION = "us-east-1"
REPO_NAME = "devops-app-repo"
APP_NAME = "app"

def get_account_id():
    url = "http://169.254.169.254/latest/dynamic/instance-identity/document"
    with urllib.request.urlopen(url) as response:
        return json.load(response)["accountId"]

def login_to_ecr(account_id):
    login_cmd = [
        "aws", "ecr", "get-login-password", "--region", REGION
    ]
    password = subprocess.check_output(login_cmd).decode().strip()
    repo_url = f"{account_id}.dkr.ecr.{REGION}.amazonaws.com"
    subprocess.run(["docker", "login", "--username", "AWS", "--password", password, repo_url], check=True)
    return repo_url

def run_container(repo_url):
    image = f"{repo_url}/{REPO_NAME}:latest"
    subprocess.run(["docker", "pull", image], check=True)
    subprocess.run(["docker", "run", "-d", "--name", APP_NAME, "-p", "80:80", image], check=True)

if __name__ == "__main__":
    account_id = get_account_id()
    repo_url = login_to_ecr(account_id)
    run_container(repo_url)