# LSTV Log Cleanup Script
# Deletes Apache logs older than 30 days
$LogPath = "C:\xampp\apache\logs"
if (Test-Path $LogPath) {
    Get-ChildItem -Path $LogPath -Include *error_log*, *access_log* -Recurse | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-30) } | Remove-Item
    Write-Host "Old logs cleaned."
}
