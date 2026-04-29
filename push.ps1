#!/usr/bin/env pwsh
Set-Location $PSScriptRoot
Write-Host "Current directory: $(Get-Location)"
Write-Host ""

# Check if .git exists
if (Test-Path .\.git) {
    Write-Host ".git folder found"

    # Check if remote exists
    $remotes = git remote -v
    if ($remotes) {
        Write-Host "Existing remotes:"
        Write-Host $remotes
    } else {
        Write-Host "No remotes configured, adding origin..."
        git remote add origin https://github.com/kanpassit/yehey.git
    }

    Write-Host ""
    Write-Host "Attempting to push..."
    git push origin main -v
    Write-Host ""
    Write-Host "Git status:"
    git status
} else {
    Write-Host "ERROR: .git folder not found in $(Get-Location)"
}

Write-Host ""
Write-Host "Press Enter to exit..."
Read-Host
