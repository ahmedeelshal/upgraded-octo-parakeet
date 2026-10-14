@echo off
setlocal
cd /d "%~dp0"
where node >nul 2>nul
if errorlevel 1 (
  echo Node.js 22.16 or newer is required. Install it from https://nodejs.org/ and try again.
  pause
  exit /b 1
)
if not exist .env copy .env.example .env >nul
if not exist node_modules\ (
  echo Installing project dependencies...
  call npm install
  if errorlevel 1 (
    echo Dependency installation failed.
    pause
    exit /b 1
  )
)
call npm start
pause
