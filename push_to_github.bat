@echo off
setlocal enabledelayedexpansion

REM Change to the Flashcards directory
cd /d "C:\Users\Mark Quion\Documents\Claude\Projects\Flashcards"

REM Create log file
set logfile=git_push_final_log.txt
(
    echo Working directory: %cd%
    echo.
    echo === Checking git status ===
    git status
    echo.
    echo === Listing remotes ===
    git remote -v
    echo.
    echo === Attempting push ===
    git push origin main -v
    echo.
    echo === Push completed ===
) > %logfile% 2>&1

REM Open log file
start %logfile%
pause
