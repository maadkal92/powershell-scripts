# Installer
$installer = "openvpn.msi"
$logPath = ".\openvpn_install.log"
$installArgs = "/i `"$PWD\$installer`" /quiet /norestart /l*v `"$PWD\$logPath`""

# Install OpenVPN
Start-Process -FilePath "msiexec.exe" -ArgumentList $installArgs -Wait -NoNewWindow

# Assuming default installation directory for OpenVPN
$OpenVPNDir = "C:\Program Files\OpenVPN Connect\"

# Check if the OpenVPN directory exists, if not, create it
if (-not (Test-Path -Path $OpenVPNDir)) {
    New-Item -Path $OpenVPNDir -ItemType Directory
}

# Copy the configuration file to the OpenVPN config directory
Copy-Item -Path ".\CLS-Profile.ovpn" -Destination $OpenVPNDir -Force