#!/usr/bin/env python3
import subprocess
import os
from pathlib import Path

script_dir = Path(__file__).parent
os.chdir(script_dir)

log_file = script_dir / "git_push_final_log.txt"

with open(log_file, 'w') as log:
    log.write(f"Working directory: {os.getcwd()}\n")
    log.write(f"Git executable: C:\\Program Files\\Git\\cmd\\git.exe\n\n")

    # Add remote if it doesn't exist
    log.write("Setting up git remote...\n")
    result = subprocess.run(
        ["C:\\Program Files\\Git\\cmd\\git.exe", "remote", "add", "origin", "https://github.com/kanpassit/yehey.git"],
        capture_output=True,
        text=True
    )
    if result.returncode != 0:
        log.write(f"Remote add returned: {result.returncode}\n")
        if result.stdout:
            log.write(f"STDOUT: {result.stdout}\n")
        if result.stderr:
            log.write(f"STDERR: {result.stderr}\n")
    else:
        log.write("Remote added successfully\n")

    log.write("\n" + "="*60 + "\n")
    log.write("Attempting git push...\n")
    log.write("="*60 + "\n\n")

    # Perform git push
    result = subprocess.run(
        ["C:\\Program Files\\Git\\cmd\\git.exe", "push", "origin", "main", "-v"],
        capture_output=True,
        text=True
    )

    log.write(result.stdout + "\n")
    if result.stderr:
        log.write("STDERR:\n" + result.stderr + "\n")

    log.write(f"\nReturn code: {result.returncode}\n")
    if result.returncode == 0:
        log.write("\n✓ SUCCESS: Push completed!\n")
    else:
        log.write(f"\n✗ Push failed with exit code {result.returncode}\n")
        log.write("\nTrying to check git status for more info...\n")
        status_result = subprocess.run(
            ["C:\\Program Files\\Git\\cmd\\git.exe", "status"],
            capture_output=True,
            text=True
        )
        log.write("\nGit status output:\n")
        log.write(status_result.stdout + "\n")
        if status_result.stderr:
            log.write("Status stderr:\n" + status_result.stderr + "\n")

print(f"Log file created: {log_file}")
print("Opening log file...")
os.startfile(log_file)
