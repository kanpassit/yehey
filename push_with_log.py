#!/usr/bin/env python3
import subprocess
import os
from pathlib import Path

script_dir = Path(__file__).parent
os.chdir(script_dir)

log_file = script_dir / "push_log.txt"

with open(log_file, 'w') as log:
    log.write(f"Working directory: {os.getcwd()}\n")
    log.write(f"Git repository check:\n")

    # Check if .git exists
    git_dir = Path(".git")
    if not git_dir.exists():
        log.write("ERROR: .git directory not found!\n")
    else:
        log.write(".git directory found ✓\n\n")

        # Check remotes
        log.write("Current git remotes:\n")
        result = subprocess.run(["git", "remote", "-v"], capture_output=True, text=True)
        if result.stdout:
            log.write(result.stdout + "\n")
        else:
            log.write("No remotes configured\n")

        # Check status
        log.write("\nGit status:\n")
        result = subprocess.run(["git", "status"], capture_output=True, text=True)
        log.write(result.stdout + "\n")

        # Attempt push
        log.write("\n" + "="*60 + "\n")
        log.write("Attempting to push to origin main...\n")
        log.write("="*60 + "\n\n")

        result = subprocess.run(
            ["git", "push", "origin", "main", "-v"],
            capture_output=True,
            text=True
        )

        log.write(result.stdout + "\n")
        if result.stderr:
            log.write("STDERR:\n" + result.stderr + "\n")

        log.write("\nReturn code: " + str(result.returncode) + "\n")
        if result.returncode == 0:
            log.write("\n✓ SUCCESS: Push completed!\n")
        else:
            log.write(f"\n✗ Push failed with exit code {result.returncode}\n")

print(f"Log file created: {log_file}")
print("Opening log file...")
os.startfile(log_file)
