#!/usr/bin/env python3
"""
Simple git initialization and push script.
Removes incomplete .git directory and creates a fresh repository.
"""
import subprocess
import os
import sys
from pathlib import Path

# Setup
work_dir = Path(__file__).parent
log_file = work_dir / "git_push_final_log.txt"
os.chdir(work_dir)

print(f"Working in: {work_dir}")

# Open log file for writing
with open(log_file, 'w') as log:
    # Write initial info
    log.write(f"Simple Git Push - {work_dir}\n")
    log.write("="*60 + "\n\n")

    def run_cmd(cmd_list, description=""):
        """Run a command and log the output."""
        if description:
            msg = f"\n{description}..."
            print(msg)
            log.write(msg + "\n")

        try:
            result = subprocess.run(cmd_list, capture_output=True, text=True, timeout=30)
            if result.stdout:
                log.write(f"Output: {result.stdout}\n")
            if result.stderr:
                log.write(f"Errors: {result.stderr}\n")
            log.write(f"Return code: {result.returncode}\n\n")
            return result.returncode
        except Exception as e:
            msg = f"Exception: {e}"
            print(msg)
            log.write(msg + "\n\n")
            return -1

    # Step 1: Remove broken .git
    print("\n[1/7] Removing broken .git directory...")
    git_dir = work_dir / ".git"
    if git_dir.exists():
        try:
            import shutil
            shutil.rmtree(git_dir)
            print("  ✓ Deleted .git")
            log.write("✓ Deleted broken .git directory\n\n")
        except Exception as e:
            log.write(f"Warning: Could not delete .git: {e}\n\n")

    # Step 2: Initialize new repository
    print("[2/7] Initializing git repository...")
    if run_cmd(["git", "init"], "Running git init") == 0:
        log.write("✓ Repository initialized\n\n")
    else:
        log.write("✗ Failed to initialize\n\n")

    # Step 3: Configure user
    print("[3/7] Configuring git user...")
    run_cmd(["git", "config", "user.email", "dev@kanpassit.com"], "Setting git email")
    run_cmd(["git", "config", "user.name", "KanPassIt Developer"], "Setting git name")

    # Step 4: Add files
    print("[4/7] Adding files...")
    if run_cmd(["git", "add", "."], "Running git add") == 0:
        log.write("✓ Files added\n\n")

    # Step 5: Commit
    print("[5/7] Creating commit...")
    run_cmd(["git", "commit", "-m", "v2.1.0: Hard caps, skip button, analytics dashboard"], "Creating commit")

    # Step 6: Add remote
    print("[6/7] Adding GitHub remote...")
    # Try to add; if it fails because it already exists, remove and re-add
    code = run_cmd(["git", "remote", "add", "origin", "https://github.com/kanpassit/yehey.git"])
    if code != 0:
        run_cmd(["git", "remote", "remove", "origin"])
        run_cmd(["git", "remote", "add", "origin", "https://github.com/kanpassit/yehey.git"])

    # Step 7: Push
    print("[7/7] Pushing to GitHub...")
    log.write("="*60 + "\n")
    log.write("PUSH ATTEMPT\n")
    log.write("="*60 + "\n")

    code = run_cmd(["git", "push", "-u", "origin", "main", "-v"], "Pushing to GitHub")

    # Summary
    log.write("\n" + "="*60 + "\n")
    if code == 0:
        log.write("✓✓✓ SUCCESS ✓✓✓\n")
        log.write("Code has been pushed to GitHub!\n")
        log.write("Repository: https://github.com/kanpassit/yehey\n")
        print("\n✓✓✓ SUCCESS! Code pushed to GitHub! ✓✓✓")
    else:
        log.write("✗ PUSH FAILED\n")
        log.write("This may be due to authentication or network issues.\n")
        log.write("You may need to:\n")
        log.write("- Set up GitHub credentials\n")
        log.write("- Create a Personal Access Token\n")
        log.write("- Configure SSH keys\n")
        print("\n✗ Push failed - check log for details")
    log.write("="*60 + "\n")

# Display log
print(f"\nLog written to: {log_file}")
print("\n" + "="*60)
with open(log_file, 'r') as f:
    print(f.read())
print("="*60)

# Try to open log file
try:
    os.startfile(log_file)
except:
    pass
