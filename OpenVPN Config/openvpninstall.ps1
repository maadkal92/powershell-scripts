# PowerShell script to install OpenVPN Connect (MSI version) and copy configuration file. Endpoint Manager script deployment for per user configuration.

# Define the log file path
$installLogPath = "C:\Program Files\OpenVPN Connect\openvpn-install.log"


# Installer file name
$installer = ".\openvpn.msi" # Update this with the actual MSI file name

# Installation command
$installArgs = "/i `"$installer`" /quiet /norestart /l*v `"$installLogPath`""

# Execute the installer
Start-Process -FilePath "msiexec.exe" -ArgumentList $installArgs -Wait -NoNewWindow

# Define the source and destination paths
$configFilesSourcePath = ".\"
$configDestinationPath = "C:\Program Files\OpenVPN Connect\config"

# Check if the destination folder exists, create it if not
if (-not (Test-Path -Path $configDestinationPath)) {
    New-Item -Path $configDestinationPath -ItemType Directory
}

# Use Join-Path to correctly handle the paths
$sourceFiles = Join-Path -Path $configFilesSourcePath -ChildPath "*.ovpn"

# Now copy the .ovpn files to the destination
Copy-Item -Path $sourceFiles -Destination $configDestinationPath -Force -Recurse -Wait -NoNewWindow
