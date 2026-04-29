# PowerShell script to reinitialize git repository and push to GitHub

$workDir = "C:\Users\Mark Quion\Documents\Claude\Projects\Flashcards"
$logFile = Join-Path $workDir "git_push_final_log.txt"

# Set working directory
Set-Location $workDir

# Start logging
$log = @()
$log += "PowerShell Git Initialization and Push"
$log += "======================================="
$log += "Working directory: $(Get-Location)"
$log += ""

try {
    # Step 1: Remove broken .git directory
    $log += "STEP 1: Removing incomplete .git directory..."
    $gitDir = Join-Path $workDir ".git"
    if (Test-Path $gitDir) {
        Remove-Item -Recurse -Force $gitDir
        $log += "✓ Removed .git directory"
    } else {
        $log += "No .git directory found"
    }
    $log += ""

    # Step 2: Initialize new repository
    $log += "STEP 2: Initializing new git repository..."
    $output = & git init 2>&1
    $log += "Output: $output"
    $log += ""

    # Step 3: Configure git user
    $log += "STEP 3: Configuring git user..."
    & git config user.email "dev@kanpassit.com" 2>&1 | Out-Null
    & git config user.name "KanPassIt Developer" 2>&1 | Out-Null
    $log += "✓ Git user configured"
    $log += ""

    # Step 4: Add all files
    $log += "STEP 4: Adding all files..."
    $output = & git add . 2>&1
    $log += "Files added"
    $log += ""

    # Step 5: Create commit
    $log += "STEP 5: Creating initial commit..."
    $output = & git commit -m "v2.1.0: Hard caps, skip button, analytics dashboard" 2>&1
    $log += "Output: $output"
    $log += ""

    # Step 6: Add remote
    $log += "STEP 6: Adding GitHub remote..."
    $output = & git remote add origin "https://github.com/kanpassit/yehey.git" 2>&1
    if ($output -like "*already exists*") {
        $log += "Remote already exists, removing and re-adding..."
        & git remote remove origin 2>&1 | Out-Null
        & git remote add origin "https://github.com/kanpassit/yehey.git" 2>&1 | Out-Null
    }
    $log += "✓ Remote configured"
    $log += ""

    # Step 7: Rename branch to main
    $log += "STEP 7: Setting up main branch..."
    $output = & git branch -M main 2>&1
    $log += "✓ Branch set to main"
    $log += ""

    # Step 8: Push to GitHub
    $log += "STEP 8: Pushing to GitHub..."
    $log += "=================================================="
    $output = & git push -u origin main -v 2>&1
    $log += "Push output:"
    $log += $output
    $log += ""

    if ($LASTEXITCODE -eq 0) {
        $log += "=================================================="
        $log += "✓✓✓ SUCCESS: Code pushed to GitHub! ✓✓✓"
        $log += "=================================================="
        $log += "Repository: https://github.com/kanpassit/yehey"
        $log += "Branch: main"
        $log += "Commit: v2.1.0 - Hard caps, skip button, analytics dashboard"
    } else {
        $log += "=================================================="
        $log += "✗ Push failed with exit code $LASTEXITCODE"
        $log += "This may be due to:"
        $log += "- GitHub authentication credentials needed"
        $log += "- Network connectivity issue"
        $log += "- Repository access permission"
        $log += ""
        $log += "If you see 'fatal: could not read Username', you may need to:"
        $log += "1. Set up GitHub credentials locally"
        $log += "2. Create a Personal Access Token on GitHub"
        $log += "3. Use SSH keys for authentication"
    }
}
catch {
    $log += "ERROR: $($_.Exception.Message)"
}

# Write log file
$log | Out-File -FilePath $logFile -Encoding UTF8

# Display results
Write-Host ""
Write-Host "Log file created: $logFile"
Write-Host ""
Write-Host "=== LOG OUTPUT ==="
$log | ForEach-Object { Write-Host $_ }

# Open log file
Start-Process notepad.exe $logFile
