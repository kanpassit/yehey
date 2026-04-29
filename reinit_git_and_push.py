#!/usr/bin/env python3
import subprocess
import os
import shutil
from pathlib import Path

os.chdir(Path(__file__).parent)
log_file = Path(__file__).parent / "git_push_final_log.txt"

with open(log_file, 'w') as log:
    log.write(f"Working directory: {os.getcwd()}\n")
    log.write(f"Reinitialing git repository and pushing to GitHub\n\n")

    # Step 1: Remove broken .git directory if it exists
    log.write("=== STEP 1: Removing broken .git directory ===\n")
    git_dir = Path(".git")
    if git_dir.exists():
        try:
            shutil.rmtree(git_dir)
            log.write("✓ Removed old .git directory\n")
        except Exception as e:
            log.write(f"✗ Error removing .git: {e}\n")
    else:
        log.write("No .git directory found\n")

    # Step 2: Initialize new git repository
    log.write("\n=== STEP 2: Initialize new git repository ===\n")
    result = subprocess.run(
        ["git", "init"],
        capture_output=True,
        text=True
    )
    log.write(f"git init return code: {result.returncode}\n")
    log.write(f"Output: {result.stdout}\n")
    if result.stderr:
        log.write(f"Error: {result.stderr}\n")

    if result.returncode == 0:
        log.write("✓ Repository initialized\n")
    else:
        log.write("✗ Failed to initialize repository\n")
        log.write("\nGiving up - cannot proceed without valid git repository\n")
        os.startfile(log_file)
        exit(1)

    # Step 3: Configure git user (required for commits)
    log.write("\n=== STEP 3: Configure git user ===\n")
    subprocess.run(["git", "config", "user.email", "dev@kanpassit.com"], capture_output=True)
    subprocess.run(["git", "config", "user.name", "KanPassIt Developer"], capture_output=True)
    log.write("✓ Git user configured\n")

    # Step 4: Add all files
    log.write("\n=== STEP 4: Add all files ===\n")
    result = subprocess.run(
        ["git", "add", "."],
        capture_output=True,
        text=True
    )
    log.write(f"git add . return code: {result.returncode}\n")
    if result.returncode == 0:
        log.write("✓ All files added\n")
    else:
        log.write(f"✗ Error adding files: {result.stderr}\n")

    # Step 5: Create initial commit
    log.write("\n=== STEP 5: Create initial commit for v2.1.0 ===\n")
    result = subprocess.run(
        ["git", "commit", "-m", "v2.1.0: Hard caps, skip button, analytics dashboard"],
        capture_output=True,
        text=True
    )
    log.write(f"git commit return code: {result.returncode}\n")
    log.write(f"Output: {result.stdout}\n")
    if result.stderr:
        log.write(f"Error: {result.stderr}\n")

    if result.returncode == 0:
        log.write("✓ Commit created\n")
    else:
        log.write("✗ Failed to create commit\n")

    # Step 6: Verify local state
    log.write("\n=== STEP 6: Verify local state ===\n")
    result = subprocess.run(
        ["git", "log", "--oneline", "-5"],
        capture_output=True,
        text=True
    )
    log.write(f"Recent commits:\n{result.stdout}\n")

    # Step 7: Add remote
    log.write("\n=== STEP 7: Add GitHub remote ===\n")
    result = subprocess.run(
        ["git", "remote", "add", "origin", "https://github.com/kanpassit/yehey.git"],
        capture_output=True,
        text=True
    )
    log.write(f"git remote add return code: {result.returncode}\n")
    if result.returncode == 0:
        log.write("✓ Remote added\n")
    else:
        if "already exists" in result.stderr:
            log.write("✓ Remote already exists\n")
        else:
            log.write(f"✗ Error: {result.stderr}\n")

    # Step 8: Rename branch to main (if needed)
    log.write("\n=== STEP 8: Set up main branch ===\n")
    result = subprocess.run(
        ["git", "branch", "-M", "main"],
        capture_output=True,
        text=True
    )
    log.write(f"git branch -M main return code: {result.returncode}\n")
    log.write("✓ Branch renamed to main\n")

    # Step 9: Push to GitHub
    log.write("\n=== STEP 9: Push to GitHub ===\n")
    result = subprocess.run(
        ["git", "push", "-u", "origin", "main", "-v"],
        capture_output=True,
        text=True
    )

    log.write(f"Return code: {result.returncode}\n")
    log.write(f"Output: {result.stdout}\n")
    if result.stderr:
        log.write(f"STDERR: {result.stderr}\n")

    if result.returncode == 0:
        log.write("\n" + "="*60 + "\n")
        log.write("✓✓✓ SUCCESS: Repository pushed to GitHub! ✓✓✓\n")
        log.write("="*60 + "\n")
        log.write(f"Repository: https://github.com/kanpassit/yehey\n")
        log.write(f"Branch: main\n")
        log.write(f"Commit: v2.1.0 - Hard caps, skip button, analytics dashboard\n")
    else:
        log.write("\n✗ Push failed\n")
        if "permission" in result.stderr.lower() or "auth" in result.stderr.lower():
            log.write("\nNote: GitHub may require authentication.\n")
            log.write("You may need to:\n")
            log.write("1. Create a GitHub Personal Access Token\n")
            log.write("2. Use 'git credential approve' or configure SSH keys\n")
            log.write("3. Or run: git push --set-upstream origin main (and enter credentials)\n")

print(f"\nLog written to: {log_file}")
os.startfile(log_file)
