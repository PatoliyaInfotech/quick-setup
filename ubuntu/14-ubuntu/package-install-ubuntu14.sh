#!/usr/bin/env bash
red=`tput setaf 1`
reset=`tput sgr0`
green=`tput setaf 2`

echo "${green}"
start=`date +%s`
echo "Start Time ${start}"
echo "${reset}"

echo "${red}"
echo "WARNING : Execute script without sudo command."
echo "${reset}"

sleep 5s

# Enable multiverse repository
sudo sed -i "/^# deb.*multiverse/ s/^# //" /etc/apt/sources.list

# Upgrade to Latest Update
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

# Install required additional dependencies
sudo apt-get build-essential -y
sudo apt-get install curl -y
sudo apt-get install libssl-dev -y
sudo apt-get install git -y

# NA-UTIL
sudo apt-get install nautilus-open-terminal -y

# Install Python
sudo apt-get install python-pip python-dev python-virtualenv python-software-properties debconf-utils -y
sudo pip install virtualenvwrapper

# Install Samba (Still you have to update config files.)
sudo apt-get install gksu -y
sudo apt-get install samba -y
sudo apt-get install system-config-samba -y

# Install Java (Auto Accept Terms)
sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update -y
sudo echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
sudo apt-get install oracle-java8-installer -y
javac -version
java -version

# System Monitor (LAN & CPU) (Recommended)
sudo apt-get install indicator-multiload -y

# WLAN-LAN Speed Monitor
sudo add-apt-repository ppa:nilarimogard/webupd8 -y
sudo apt-get update -y
sudo apt-get install indicator-netspeed -y

# Install Docker CE
sudo apt-get install apt-transport-https ca-certificates curl Software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update -y
sudo apt-get install docker-ce -y

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

# Set Access for Current User
sudo chown $USER:$USER /var/run/docker.sock

# Remove useless files from the APT cache
sudo apt-get autoclean -y

# Upgrade to Latest Update
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

# Install NVM
curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
export ENV NODE_VERSION=8.11.3
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Install Node
nvm install $NODE_VERSION

# Install Other Packages
npm install nodemon -g
npm install typescript -g
npm install ts-node -g

# Install Angular CLI
npm install -g @angular/cli@latest

# Get SUDO access without password
sudo chmod 0400 /etc/sudoers
echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo EDITOR='tee -a' visudo

# Upgrade to Latest Update
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

# Remove useless files from the APT cache
sudo apt-get autoclean -y

# Pull Mongo 3.6 for Docker
docker pull bitnami/mongodb:3.6

echo "${green}"
end=`date +%s`
echo "End Time ${end}"
seconds=$((end-start))
echo "Total Time Taken In Seconds ${seconds}"
eval "echo $(date -ud "@$seconds" +'%H hours %M minutes %S seconds')"
echo "${reset}"