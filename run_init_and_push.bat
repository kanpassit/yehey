@echo off
REM Run PowerShell script to initialize git and push to GitHub
cd /d "C:\Users\Mark Quion\Documents\Claude\Projects\Flashcards"
powershell -NoProfile -ExecutionPolicy Bypass -File "init_and_push.ps1"
pause
