#!/bin/bash
# Simple deployment script - requires GITHUB_TOKEN environment variable

if [ -z "$GITHUB_TOKEN" ]; then
    echo "Error: GITHUB_TOKEN environment variable not set"
    echo "Usage: GITHUB_TOKEN=your_token ./deploy.sh"
    exit 1
fi

cd "$(dirname "$0")" || exit 1

python3 << 'EOFPYTHON'
import base64
import requests
import os

# Read the local fixed index.html
with open('index.html', 'rb') as f:
    file_content = f.read()

# Get GitHub token from environment
github_token = os.environ.get('GITHUB_TOKEN')

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
    "message": "Fix: Comprehensive error handling in init() and loadQuestions() - adds timeouts, defensive QB initialization, and proper view transitions",
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
    exit(1)
EOFPYTHON
