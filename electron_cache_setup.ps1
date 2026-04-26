<#
Electron Cache Setup Script
For accelerating TyranoBuilder Windows game packaging
Version: 1.0
Date: 2026-04-26
#>

Write-Host "===================================="
Write-Host "TyranoBuilder Electron Cache Setup"
Write-Host "===================================="

# Check operating system
if ($env:OS -ne "Windows_NT") {
    Write-Host "Error: This script only works on Windows!" -ForegroundColor Red
    pause
    exit 1
}

# Set variables
$electronVersion = "24.2.0"
$electronMirror = "https://npmmirror.com/mirrors/electron/"
$fileName = "electron-v$electronVersion-win32-x64.zip"
$downloadUrl = "$electronMirror/v$electronVersion/$fileName"
$tempDir = "$env:TEMP\electron_cache_setup"
$cacheRoot = "$env:APPDATA\electron\Cache"

# Calculate hash for GitHub URL (for cache directory)
$githubUrl = "https://github.com/electron/electron/releases/download/v$electronVersion/$fileName"
$parsedUrl = [System.Uri]$githubUrl
$pathname = $parsedUrl.LocalPath
$dirName = Split-Path $pathname -Parent
$strippedUrl = $parsedUrl.Scheme + "://" + $parsedUrl.Host + $dirName
$hasher = [System.Security.Cryptography.SHA256]::Create()
$bytes = [System.Text.Encoding]::UTF8.GetBytes($strippedUrl)
$hash = $hasher.ComputeHash($bytes)
$hashString = [System.BitConverter]::ToString($hash).Replace("-", "").ToLower()
$cacheDir = "$cacheRoot\$hashString"

# Create temporary directory
if (!(Test-Path $tempDir)) {
    New-Item -Path $tempDir -ItemType Directory -Force | Out-Null
    Write-Host "Created temp directory: $tempDir" -ForegroundColor Green
}

# Download Electron
$downloadPath = "$tempDir\$fileName"
if (!(Test-Path $downloadPath)) {
    Write-Host "Downloading Electron $electronVersion from mirror..." -ForegroundColor Cyan
    try {
        Invoke-WebRequest -Uri $downloadUrl -OutFile $downloadPath -ErrorAction Stop
        Write-Host "Download completed!" -ForegroundColor Green
    } catch {
        Write-Host "Download failed: $($_.Exception.Message)" -ForegroundColor Red
        pause
        exit 1
    }
} else {
    Write-Host "Electron already exists, skipping download." -ForegroundColor Yellow
}

# Check file size
$fileSize = (Get-Item $downloadPath).Length / 1MB
if ($fileSize -lt 90) {
    Write-Host "Warning: File size seems incorrect, may be incomplete!" -ForegroundColor Yellow
    Write-Host "File size: $([math]::Round($fileSize, 2)) MB (expected around 95 MB)" -ForegroundColor Yellow
}

# Create cache directory
if (!(Test-Path $cacheRoot)) {
    New-Item -Path $cacheRoot -ItemType Directory -Force | Out-Null
    Write-Host "Created cache root directory: $cacheRoot" -ForegroundColor Green
}

if (!(Test-Path $cacheDir)) {
    New-Item -Path $cacheDir -ItemType Directory -Force | Out-Null
    Write-Host "Created cache directory: $cacheDir" -ForegroundColor Green
}

# Copy file to cache directory
$cacheFilePath = "$cacheDir\$fileName"
if (!(Test-Path $cacheFilePath)) {
    Write-Host "Copying file to cache directory..." -ForegroundColor Cyan
    try {
        Copy-Item -Path $downloadPath -Destination $cacheFilePath -Force -ErrorAction Stop
        Write-Host "Copy completed!" -ForegroundColor Green
    } catch {
        Write-Host "Copy failed: $($_.Exception.Message)" -ForegroundColor Red
        pause
        exit 1
    }
} else {
    Write-Host "Cache file already exists, skipping copy." -ForegroundColor Yellow
}

# Set environment variable
Write-Host "Setting ELECTRON_MIRROR environment variable..." -ForegroundColor Cyan
[Environment]::SetEnvironmentVariable("ELECTRON_MIRROR", $electronMirror, "User")
Write-Host "Environment variable set to: $electronMirror" -ForegroundColor Green

# Clean up temporary files
Write-Host "Cleaning up temporary files..." -ForegroundColor Cyan
Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue
Write-Host "Temporary files cleaned up." -ForegroundColor Green

# Completion message
Write-Host "===================================="
Write-Host "Operation completed!" -ForegroundColor Green
Write-Host "===================================="
Write-Host "Completed operations:"
Write-Host "1. Downloaded Electron $electronVersion Windows x64"
Write-Host "2. Configured cache directory structure"
Write-Host "3. Set ELECTRON_MIRROR environment variable"
Write-Host ""
Write-Host "You can now open TyranoBuilder to package Windows version games,"
Write-Host "the packaging process will use local cache without re-downloading Electron."
Write-Host ""
Write-Host "Note: You may need to restart your computer for environment variable to take effect."
Write-Host "===================================="
pause