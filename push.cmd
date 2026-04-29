@echo off
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "push.ps1"
pause
