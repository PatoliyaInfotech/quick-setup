#!/usr/bin/env bash
red=$(tput setaf 1)
reset=$(tput sgr0)
green=$(tput setaf 2)

echo "Thank you, we are installting for the Server"

echo "${green}"
start=$(date +%s)
echo "Start Time ${start}"
echo "${reset}"

echo "${red}"
echo "WARNING : Execute script without sudo command."
echo "${reset}"

# Get Username
CURRENT_USER=$USER
echo "$CURRENT_USER"

# Enable multiverse repository
# sudo sed -i "/^# deb.*multiverse/ s/^# //" /etc/apt/sources.list

# Upgrade to Latest Update
sudo apt-get update -q -y
sudo apt-get upgrade -q -y
sudo apt-get dist-upgrade -q -y

# Install required additional dependencies
sudo apt-get install build-essential -y
sudo apt-get install curl -y
sudo apt-get install libssl-dev -y
sudo apt-get install git -q -y

# Install nginx
sudo apt install nginx -y

# Install Python
# sudo apt-get install python-pip python-dev python-virtualenv python-software-properties debconf-utils -y
# sudo apt install software-properties-common apt-transport-https wget -y
# sudo pip install virtualenvwrapper

# Install Samba (Still you have to update config files.)
# sudo apt-get install samba -y
# sudo apt-get install system-config-samba -y

# Install Java (Auto Accept Terms)
# sudo apt-get update -q -y
# sudo add-apt-repository ppa:webupd8team/java -y
# sudo apt-get install oracle-java8-installer -y
# javac -version
# java -version

# Install Docker CE
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y
sudo apt-get update -q -y
sudo apt-get install docker-ce -y

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

# Set Access for Current User
# sudo chown $USER:$USER /var/run/docker.sock
sudo usermod -a -G docker "$USER"

# Install NVM
curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Install Node
export ENV NODE_VERSION=14.19.3
nvm install $NODE_VERSION

# Install Other Packages
npm install nodemon -g
npm install typescript -g

# Install Angular CLI
# export NG_CLI_ANALYTICS=false
# npm install -g @angular/cli@latest --force
# ng analytics off

# Get SUDO access without password
sudo chmod 0400 /etc/sudoers
echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo EDITOR='tee -a' visudo

# Pull Images for Docker
# docker pull bitnami/redis

# Upgrade to Latest Update
sudo apt-get update -q -y
sudo apt-get upgrade -q -y
sudo apt-get dist-upgrade -q -y

# Remove useless files from the APT cache
sudo apt autoremove -y
sudo apt-get autoclean -y

echo "${green}"
end=$(date +%s)
# echo "End Time ${end}"
seconds=$((end - start))
echo "Installation has been Completed !"
echo "Total Time Taken In Seconds ${seconds}"
eval "echo $(date -ud "@$seconds" +'%H hours %M minutes %S seconds')"
echo "${reset}"
