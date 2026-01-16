# Helper to Generate LSTV SSL Certificate
$OpenSSL = "C:\xampp\apache\bin\openssl.exe"
$Key = "C:\xampp\apache\conf\ssl_self\lstv96example.com.key"
$Crt = "C:\xampp\apache\conf\ssl_self\lstv96example.com.crt"

New-Item -ItemType Directory -Force -Path "C:\xampp\apache\conf\ssl_self" | Out-Null
& $OpenSSL req -x509 -nodes -days 365 -newkey rsa:2048 -keyout "$Key" -out "$Crt" -subj "/C=PH/ST=MetroManila/L=Caloocan/O=LeeSystems/CN=lstv96example.com"
Write-Host "Certificate Created!"
