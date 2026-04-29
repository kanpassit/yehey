#!/usr/bin/env python3
import subprocess
import os
from pathlib import Path

# Work in the current directory (Flashcards folder)
os.chdir(Path(__file__).parent)

log_file = Path(__file__).parent / "git_push_final_log.txt"

print("Step 1: Fixing .git/config...")

# Read current config
config_file = Path(".git/config")
try:
    with open(config_file, 'r') as f:
        config_content = f.read()
    print(f"Current config:\n{config_content}\n")
except Exception as e:
    print(f"Error reading config: {e}")
    config_content = ""

# Check if origin remote is already configured
if 'remote "origin"' not in config_content:
    print("Adding remote 'origin' to .git/config...")
    with open(config_file, 'a') as f:
        f.write('[remote "origin"]\n')
        f.write('\turl = https://github.com/kanpassit/yehey.git\n')
        f.write('\tfetch = +refs/heads/*:refs/remotes/origin/*\n')
    print("✓ Remote added to config")
else:
    print("✓ Remote 'origin' already configured")

# Now try git commands
print("\nStep 2: Testing git commands...")

with open(log_file, 'w') as log:
    log.write(f"Working directory: {os.getcwd()}\n")
    log.write(f"Python: {__file__}\n\n")

    # Test git remote
    print("Checking remotes...")
    result = subprocess.run(
        ["git", "remote", "-v"],
        capture_output=True,
        text=True
    )
    log.write(f"git remote -v return code: {result.returncode}\n")
    log.write(f"Output: {result.stdout}\n")
    if result.stderr:
        log.write(f"Error: {result.stderr}\n")
    print(f"  Return code: {result.returncode}")
    if result.returncode == 0:
        print(f"  ✓ Remotes:\n{result.stdout}")
    else:
        print(f"  ✗ Error: {result.stderr}")

    # Test git status
    print("\nChecking status...")
    result = subprocess.run(
        ["git", "status"],
        capture_output=True,
        text=True
    )
    log.write(f"\ngit status return code: {result.returncode}\n")
    log.write(f"Output: {result.stdout}\n")
    if result.stderr:
        log.write(f"Error: {result.stderr}\n")
    print(f"  Return code: {result.returncode}")
    if result.returncode == 0:
        print(f"  ✓ Repository recognized")
    else:
        print(f"  ✗ Error: {result.stderr}")

    # Try push
    print("\nAttempting push...")
    log.write(f"\n{'='*60}\n")
    log.write(f"Attempting git push...\n")
    log.write(f"{'='*60}\n")

    result = subprocess.run(
        ["git", "push", "origin", "main", "-v"],
        capture_output=True,
        text=True
    )

    log.write(f"Return code: {result.returncode}\n")
    log.write(f"STDOUT:\n{result.stdout}\n")
    if result.stderr:
        log.write(f"STDERR:\n{result.stderr}\n")

    if result.returncode == 0:
        log.write("\n✓✓✓ SUCCESS: Push completed! ✓✓✓\n")
        print("✓ SUCCESS: Push completed!")
    else:
        log.write(f"\n✗ Push failed with exit code {result.returncode}\n")
        print(f"✗ Push failed: {result.stderr}")

print(f"\nLog saved to: {log_file}")
print("Opening log file...")
os.startfile(log_file)
