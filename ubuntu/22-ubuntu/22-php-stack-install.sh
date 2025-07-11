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

# Install Apache2
echo "${green}Installing Apache2...${reset}"
if ! sudo apt install -y apache2; then
    echo "${red}Failed to install Apache2.${reset}"
    exit 1
fi
# Enable and start Apache
sudo systemctl enable apache2
sudo systemctl start apache2
echo "${green}Apache2 status: $(systemctl is-active apache2)${reset}"

# Install PHP (multiple versions: 7.4, 8.2, 8.4)
echo "${green}Installing PHP 7.4, 8.2, 8.4...${reset}"
sudo add-apt-repository -y ppa:ondrej/php
if ! sudo apt update -y || ! sudo apt install -y php7.4 libapache2-mod-php7.4 php7.4-mysql php7.4-curl php7.4-xml php7.4-mbstring php7.4-zip php7.4-bcmath php7.4-cli php7.4-common php7.4-gd php7.4-json php8.2 libapache2-mod-php8.2 php8.2-mysql php8.2-curl php8.2-xml php8.2-mbstring php8.2-zip php8.2-bcmath php8.2-cli php8.2-common php8.2-gd php8.4 libapache2-mod-php8.4 php8.4-mysql php8.4-curl php8.4-xml php8.4-mbstring php8.4-zip php8.4-bcmath php8.4-cli php8.4-common php8.4-gd; then
    echo "${red}Failed to install PHP versions.${reset}"
    exit 1
fi
# Verify PHP installations
for version in 7.4 8.2 8.4; do
    if php$version -v >/dev/null 2>&1; then
        echo "${green}PHP $version installed: $(php$version -v | head -n 1)${reset}"
    else
        echo "${red}PHP $version installation could not be verified.${reset}"
    fi
done

# Reload Apache to apply PHP module
sudo systemctl reload apache2

# Install phpMyAdmin
echo "${green}Installing phpMyAdmin...${reset}"
sudo apt install -y phpmyadmin

# Symlink phpMyAdmin to Apache root (optional if not auto-configured)
if [ ! -e /var/www/html/phpmyadmin ]; then
    sudo ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
    echo "${green}Symlinked phpMyAdmin to /var/www/html/phpmyadmin${reset}"
fi

# Allow through firewall if UFW is active
if sudo ufw status | grep -q "Status: active"; then
    echo "${green}UFW detected: Allowing Apache ports...${reset}"
    sudo ufw allow 'Apache Full'
fi

# Enable Apache rewrite module
echo "${green}Enabling Apache mod_rewrite...${reset}"
sudo a2enmod rewrite
# Restart Apache to apply changes
sudo systemctl restart apache2

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
