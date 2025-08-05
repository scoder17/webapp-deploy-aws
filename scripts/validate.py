# #!/usr/bin/env python3
# import urllib.request

# try:
#     response = urllib.request.urlopen("http://localhost")
#     if response.status == 200:
#         print("App is healthy")
#     else:
#         raise Exception("Unhealthy")
# except Exception as e:
#     print("Validation failed:", e)
#     exit(1)

#!/usr/bin/env python3
import urllib.request
import time

url = "http://localhost"
max_retries = 5
wait_seconds = 5

for i in range(max_retries):
    try:
        response = urllib.request.urlopen(url, timeout=2)
        if response.status == 200:
            print("App is healthy")
            exit(0)
        else:
            print(f"Attempt {i+1}: Unexpected status {response.status}")
    except Exception as e:
        print(f"Attempt {i+1}: App not ready ({e})")
    time.sleep(wait_seconds)

print("Validation failed: app did not become healthy in time.")
exit(1)
