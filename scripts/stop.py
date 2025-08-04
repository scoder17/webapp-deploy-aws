#!/usr/bin/env python3
import subprocess

APP_NAME = "app"

def stop_container():
    subprocess.run(["docker", "stop", APP_NAME], check=False)
    subprocess.run(["docker", "rm", APP_NAME], check=False)

if __name__ == "__main__":
    stop_container()