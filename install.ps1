# install.ps1
# RUN AS ADMINISTRATOR

$XAMPP_ROOT = "C:\xampp"
$DEPLOY_ROOT = $PSScriptRoot # The folder where this script is running

Write-Host "Starting LSTV Security Hardening & Deployment..." -ForegroundColor Cyan

# 1. Stop Services to allow file overwrites
Write-Host "Stopping Services..."
Stop-Service "Apache2.4" -ErrorAction SilentlyContinue
Stop-Service "mysql" -ErrorAction SilentlyContinue

# 2. Backup Default Configs (Just in case)
Write-Host "Backing up original configs..."
Copy-Item "$XAMPP_ROOT\apache\conf\httpd.conf" "$XAMPP_ROOT\apache\conf\httpd.conf.bak" -Force
Copy-Item "$XAMPP_ROOT\php\php.ini" "$XAMPP_ROOT\php\php.ini.bak" -Force
Copy-Item "$XAMPP_ROOT\mysql\bin\my.ini" "$XAMPP_ROOT\mysql\bin\my.ini.bak" -Force

# 3. Deploy "Golden" Config Files (Replaces Manual Editing)
Write-Host "Deploying Hardened Configurations..."
Copy-Item "$DEPLOY_ROOT\configs\httpd.conf" "$XAMPP_ROOT\apache\conf\httpd.conf" -Force
Copy-Item "$DEPLOY_ROOT\configs\httpd-ssl.conf" "$XAMPP_ROOT\apache\conf\extra\httpd-ssl.conf" -Force
Copy-Item "$DEPLOY_ROOT\configs\php.ini" "$XAMPP_ROOT\php\php.ini" -Force
Copy-Item "$DEPLOY_ROOT\configs\my.ini" "$XAMPP_ROOT\mysql\bin\my.ini" -Force

# 4. Install PHP Extensions
Write-Host "Installing PHP Extensions..."
Copy-Item "$DEPLOY_ROOT\extensions\php_dbase.dll" "$XAMPP_ROOT\php\ext\" -Force
Copy-Item "$DEPLOY_ROOT\extensions\ixed.7.3ts.win" "$XAMPP_ROOT\php\ext\" -Force
# Note: Since your 'Golden' php.ini already has "extension=..." lines, we don't need to edit text.

# 5. Automate SSL Certificate Generation (Non-Interactive)
Write-Host "Generating Self-Signed SSL..."
$OpenSSL = "$XAMPP_ROOT\apache\bin\openssl.exe"
$KeyPath = "$XAMPP_ROOT\apache\conf\ssl_self\lstv96example.com.key"
$CrtPath = "$XAMPP_ROOT\apache\conf\ssl_self\lstv96example.com.crt"

# Create directory if not exists
New-Item -ItemType Directory -Force -Path "$XAMPP_ROOT\apache\conf\ssl_self" | Out-Null

# Run OpenSSL without user prompts
& $OpenSSL req -x509 -nodes -days 365 -newkey rsa:2048 -keyout "$KeyPath" -out "$CrtPath" -subj "/C=PH/ST=MetroManila/L=Caloocan/O=LeeSystems/CN=lstv96example.com"

# 6. Setup Log Rotation Task Scheduler
Write-Host "Setting up Task Scheduler..."
$ScriptPath = "C:\Scripts\CleanOldApacheLogs.ps1"
New-Item -ItemType Directory -Force -Path "C:\Scripts" | Out-Null
Copy-Item "$DEPLOY_ROOT\scripts\CleanOldApacheLogs.ps1" $ScriptPath -Force

$Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -File `"$ScriptPath`""
$Trigger = New-ScheduledTaskTrigger -Monthly
Register-ScheduledTask -TaskName "Delete Old Apache Logs" -Action $Action -Trigger $Trigger -Force -User "SYSTEM"

# 7. Restart Services
Write-Host "Restarting Services..."
Start-Service "Apache2.4"
Start-Service "mysql"

Write-Host "Deployment Complete! System is Hardened." -ForegroundColor Green