#!/usr/bin/env python3
import subprocess
import os
from pathlib import Path

script_dir = Path(__file__).parent
os.chdir(script_dir)

print(f"Working directory: {os.getcwd()}")
print(f"Git repository check:")

# Check if .git exists
git_dir = Path(".git")
if not git_dir.exists():
    print("ERROR: .git directory not found!")
else:
    print(".git directory found ✓")

    # Check remotes
    print("\nCurrent git remotes:")
    result = subprocess.run(["git", "remote", "-v"], capture_output=True, text=True)
    if result.stdout:
        print(result.stdout)
    else:
        print("No remotes configured")

    # Check status
    print("\nGit status:")
    result = subprocess.run(["git", "status"], capture_output=True, text=True)
    print(result.stdout)

    # Attempt push
    print("\n" + "="*60)
    print("Attempting to push to origin main...")
    print("="*60 + "\n")

    result = subprocess.run(
        ["git", "push", "origin", "main", "-v"],
        capture_output=True,
        text=True
    )

    print(result.stdout)
    if result.stderr:
        print("STDERR:", result.stderr)

    if result.returncode == 0:
        print("\n✓ SUCCESS: Push completed!")
    else:
        print(f"\n✗ Push returned exit code {result.returncode}")

input("\nPress Enter to exit...")
