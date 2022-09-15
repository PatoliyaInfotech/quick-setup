#!/usr/bin/env bash
red=`tput setaf 1`
reset=`tput sgr0`
green=`tput setaf 2`

echo "Thank you, we are installting JS for your system"

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

#Install MongoDB
echo "Installing MongoDB Server..."
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo systemctl start mongod

#Install Mongo Compass
echo "Installing Mongo Compass Server..."
wget https://downloads.mongodb.com/compass/mongodb-compass_1.33.0_amd64.deb
sudo dpkg -i mongodb-compass_1.33.0_amd64.deb

#Install NodeJS
echo "Installing NodeJS..."
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt install nodejs

#Install NodeJS Other packages
echo "Installing NodeJS Other Packages..."
sudo apt install build-essential

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