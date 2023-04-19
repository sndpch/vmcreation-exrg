#!/bin/bash

# Check if running with root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root. Exiting..."
   exit 1
fi

# Update package lists
apt update

# Install dependencies
apt -y install apt-transport-https curl gnupg ca-certificates

# Import Qualys GPG key
#curl -fsSL https://shields.qualys.com/qpa/gpg | apt-key add -
# Need download link 

# Add Qualys repository
#echo "deb https://shields.qualys.com/qpa/ dpkg-security main" > /etc/apt/sources.list.d/qualys.list
# Need Download Link 

# Update package lists
apt update

# Install Qualys package
apt -y install qualys-cloud-agent

# Start Qualys agent service
systemctl start qualys-cloud-agent

# Enable Qualys agent service to start on boot
systemctl enable qualys-cloud-agent

# Print installation complete message
echo "Qualys installation complete."
