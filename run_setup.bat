@echo off

:: Open environment variables editor
start sysdm.cpl

:: Open run.txt if it exists
if exist run.txt (
    start run.txt
)

echo ====================================
echo TyranoBuilder Electron Cache Setup
echo ====================================
echo.
echo This script will automatically download Electron 24.2.0 and configure cache
echo to speed up the Windows game packaging process in TyranoBuilder
echo.
echo Please run this script as administrator
echo.

:: Check PowerShell version
powershell -Command "$PSVersionTable.PSVersion.Major" > ps_version.txt
set /p PS_VERSION=<ps_version.txt
del ps_version.txt

if %PS_VERSION% LSS 5 (
    echo Error: PowerShell 5.0 or higher is required
    echo Please upgrade PowerShell and try again
    exit /b 1
)

:: Run PowerShell script
powershell -ExecutionPolicy Bypass -File "electron_cache_setup.ps1"

:: Create run.txt file
echo Setup completed > run.txt

:: Pause to show results
pause