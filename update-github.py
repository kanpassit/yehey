#!/usr/bin/env python3
import base64
import requests
import json

# Read the local fixed index.html
with open('index.html', 'rb') as f:
    file_content = f.read()

# Get GitHub token from environment or prompt
github_token = input("Enter your GitHub personal access token: ").strip()

# GitHub API endpoint
url = "https://api.github.com/repos/kanpassit/yehey/contents/index.html"

# Get current file SHA
headers = {
    "Authorization": f"token {github_token}",
    "Accept": "application/vnd.github.v3+json"
}

response = requests.get(url, headers=headers)
if response.status_code != 200:
    print(f"Error getting file: {response.status_code}")
    print(response.text)
    exit(1)

current_file = response.json()
sha = current_file['sha']

# Prepare the update
encoded_content = base64.b64encode(file_content).decode('utf-8')

data = {
    "message": "Fix: Guard currentUser initialization in renderSubjectsView to prevent null reference errors on course selection page",
    "content": encoded_content,
    "sha": sha
}

# Update the file
response = requests.put(url, headers=headers, json=data)
if response.status_code in [200, 201]:
    print("✅ File updated successfully!")
    print(f"Commit: {response.json()['commit']['sha']}")
    print("Vercel auto-deployment triggered. The site will update in ~30 seconds.")
else:
    print(f"Error updating file: {response.status_code}")
    print(response.text)
