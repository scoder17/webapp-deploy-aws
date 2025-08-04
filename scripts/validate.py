#!/usr/bin/env python3
import urllib.request

try:
    response = urllib.request.urlopen("http://localhost")
    if response.status == 200:
        print("App is healthy")
    else:
        raise Exception("Unhealthy")
except Exception as e:
    print("Validation failed:", e)
    exit(1)