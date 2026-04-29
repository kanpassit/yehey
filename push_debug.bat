@echo off
cd /d "%~dp0"
echo Pushing to GitHub...
git push origin main -v
if %errorlevel% equ 0 (
    echo SUCCESS: Push completed
) else (
    echo FAILED: Push returned error code %errorlevel%
)
echo.
echo Git status:
git status
pause
