#!/usr/bin/env bash
red=`tput setaf 1`
reset=`tput sgr0`
green=`tput setaf 2`

echo "Thank you, we are installting LAMP for your system"

echo "${green}"
start=`date +%s`
echo "Start Time ${start}"
echo "${reset}"

echo "${red}"
echo "WARNING : Execute script without sudo command."
echo "${reset}"

# Get Username
CURRENT_USER=$USER
echo "$CURRENT_USER"

# Upgrade to Latest Update
sudo apt-get update -q -y
sudo apt-get upgrade -q -y
sudo apt-get dist-upgrade -q -y

#Install Apache2
echo "Installing Apache2 Server..."
sudo apt install apache2

#Install MySQL
echo "Installing MySQL Server..."
sudo apt install mysql-server

#Secure MySQL installation
echo "Securing MySQL MySQL Server..."
sudo mysql_secure_installation

#Install PHP7.4
echo "Installing PHP 7.4 "
sudo apt install php libapache2-mod-php php-mysql

#Restarting Apache2
sudo systemctl reload apache2

#Installing PHP Common packages
echo "Installing PHP 7.4 Modules"
sudo apt install php-redis php-zip php-curl php-xmlrpc php-bcmath php-json php-xml php-mcrypt

#Installing PHPMyAdmin
echo "Installing PHPMyAdmin"
sudo apt install phpmyadmin

# Remove useless files from the APT cache
sudo apt autoremove -y
sudo apt-get autoclean -y

echo "${green}"
end=`date +%s`
# echo "End Time ${end}"
seconds=$((end-start))
echo "Installation has been Completed !"
echo "Total Time Taken In Seconds ${seconds}"
eval "echo $(date -ud "@$seconds" +'%H hours %M minutes %S seconds')"
echo "${reset}"