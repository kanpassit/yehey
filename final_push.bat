@echo off
cd /d "C:\Users\Mark Quion\Documents\Claude\Projects\Flashcards"

echo Configuring git user...
git config user.email "dev@kanpassit.com"
git config user.name "KanPassIt Developer"

echo Adding all files...
git add .

echo Creating commit...
git commit -m "v2.1.0: Hard caps, skip button, analytics dashboard"

echo Adding GitHub remote...
git remote add origin https://github.com/kanpassit/yehey.git

echo Renaming branch to main...
git branch -M main

echo Pushing to GitHub...
git push -u origin main -v

echo Done!
pause
