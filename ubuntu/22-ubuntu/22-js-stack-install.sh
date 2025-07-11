#!/usr/bin/env bash
red=$(tput setaf 1)
reset=$(tput sgr0)
green=$(tput setaf 2)

echo "${green}Starting development environment setup for Ubuntu 22.04...${reset}"

# Check if running on Ubuntu 22.04
if ! lsb_release -d | grep -q "Ubuntu 22.04"; then
    echo "${red}This script is designed for Ubuntu 22.04. Exiting.${reset}"
    exit 1
fi

# Check for internet connectivity
if ! ping -c 1 google.com >/dev/null 2>&1; then
    echo "${red}No internet connection. Please connect to the internet and try again.${reset}"
    exit 1
fi

# Record start time
start=$(date +%s)
echo "${green}Start Time: $(date -d "@$start")${reset}"

# Warn about sudo usage
echo "${red}Note: This script requires sudo for system-level installations. Ensure you have admin privileges.${reset}"

# Get current user
CURRENT_USER=$USER
echo "${green}Current User: $CURRENT_USER${reset}"

# Update and upgrade system
echo "${green}Updating and upgrading system...${reset}"
if ! sudo apt update -y || ! sudo apt upgrade -y || ! sudo apt full-upgrade -y; then
    echo "${red}Failed to update or upgrade system. Check network or permissions.${reset}"
    exit 1
fi

# Install MongoDB
echo "${green}Installing MongoDB...${reset}"
wget -qO - https://www.mongodb.org/static/pgp/server-8.0.asc | sudo gpg --dearmor -o /usr/share/keyrings/mongodb-server-8.0.gpg
echo "deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
if ! sudo apt update -y || ! sudo apt install -y mongodb-org; then
    echo "${red}Failed to install MongoDB.${reset}"
    exit 1
fi
sudo systemctl start mongod
if command -v mongod >/dev/null 2>&1; then
    echo "${green}MongoDB installed: $(mongod --version | head -n 1)${reset}"
else
    echo "${red}MongoDB installation could not be verified.${reset}"
    exit 1
fi

# Install MongoDB Compass
echo "${green}Installing MongoDB Compass...${reset}"
wget -O /tmp/mongodb-compass.deb https://downloads.mongodb.com/compass/mongodb-compass_1.46.2_amd64.deb
if ! sudo apt install -y /tmp/mongodb-compass.deb; then
    echo "${red}Failed to install MongoDB Compass.${reset}"
    rm -f /tmp/mongodb-compass.deb
    exit 1
fi
rm -f /tmp/mongodb-compass.deb
if command -v mongodb-compass >/dev/null 2>&1; then
    echo "${green}MongoDB Compass installed.${reset}"
else
    echo "${red}MongoDB Compass installation could not be verified.${reset}"
    exit 1
fi

# Install TypeScript globally
echo "${green}Installing TypeScript globally...${reset}"
if npm install -g typescript; then
    echo "${green}TypeScript installed successfully: $(tsc --version)${reset}"
else
    echo "${red}Failed to install TypeScript.${reset}"
    exit 1
fi

# Install Sqlectron
echo "${green}Installing Sqlectron...${reset}"
wget -O /tmp/sqlectron.deb https://github.com/sqlectron/sqlectron-gui/releases/download/v1.38.0/sqlectron_1.38.0_amd64.deb
if ! sudo apt install -y /tmp/sqlectron.deb; then
    echo "${red}Failed to install Sqlectron.${reset}"
    rm -f /tmp/sqlectron.deb
    exit 1
fi
rm -f /tmp/sqlectron.deb
if command -v sqlectron >/dev/null 2>&1; then
    echo "${green}Sqlectron installed.${reset}"
else
    echo "${red}Sqlectron installation could not be verified.${reset}"
    exit 1
fi

# Clean up APT cache
echo "${green}Cleaning up APT cache...${reset}"
if ! sudo apt autoremove -y || ! sudo apt autoclean -y; then
    echo "${red}Failed to clean APT cache.${reset}"
    exit 1
fi

# Calculate and display execution time
end=$(date +%s)
seconds=$((end - start))
echo "${green}"
echo "Installation completed successfully!"
echo "Total Time Taken: $(date -ud "@$seconds" +'%H hours %M minutes %S seconds')"
echo "${reset}"
