#!/usr/bin/env bash
red=`tput setaf 1`
reset=`tput sgr0`
green=`tput setaf 2`

echo Press 1 for Desktop OS, and Press 2 for Server OS?
read varname
OS_TYPE='DESKTOP'
if [ $varname -eq "2" ]
then
    OS_TYPE="SERVER"
fi
echo "Thank you, we are installting for the $OS_TYPE"

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

# Enable multiverse repository
sudo sed -i "/^# deb.*multiverse/ s/^# //" /etc/apt/sources.list

# Upgrade to Latest Update
sudo apt-get update -q -y
sudo apt-get upgrade -q -y
sudo apt-get dist-upgrade -q -y

# Install required additional dependencies
sudo apt-get install build-essential -y
sudo apt-get install curl -y
sudo apt-get install libssl-dev -y
sudo apt-get install git -q -y

# Install Python
sudo apt-get install python-pip python-dev python-virtualenv python-software-properties debconf-utils -y
sudo apt install software-properties-common apt-transport-https wget -y
sudo pip install virtualenvwrapper

if [ $OS_TYPE == "DESKTOP" ]
then
    # -------------------- Desktop Installation Start -------------------- #
    # Speed Monitor
    sudo apt-add-repository ppa:fixnix/netspeed -y
    sudo apt-get update -q -y
    sudo apt-get install indicator-netspeed-unity -y

    # Install Anydesk
    wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
    sudo echo "deb http://deb-archive.anydesk.com/amd64/ /" > /etc/apt/sources.list.d/anydesk-archive.list
    sudo apt update -y
    sudo apt install anydesk -y
    echo password@7 | sudo anydesk --set-password

    # Install Google Chrome
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
    sudo apt-get update  -y
    sudo apt-get install google-chrome-stable -y

    # Install snapd
    sudo apt install snapd -y

    # Install Slack
    sudo snap install slack --classic

    # Install Skype
    sudo snap install skype --classic

    # Install Smartgit
    sudo add-apt-repository ppa:eugenesan/ppa -y
    sudo apt-get update -q -y
    sudo apt-get install smartgit -y

    # Install Postman
    sudo snap install postman

    # Install Visiul Code
    sudo snap install code --classic

    # Install Visual Code Extension
    sudo code --install-extension monokai.theme-monokai-pro-vscod --user-data-dir
    sudo code --install-extension christian-kohler.npm-intellisense --user-data-dir
    sudo code --install-extension christian-kohler.path-intellisense --user-data-dir
    sudo code --install-extension msjsdiag.debugger-for-chrome --user-data-dir
    sudo code --install-extension EditorConfig.EditorConfig --user-data-dir
    sudo code --install-extension michelemelluso.code-beautifier --user-data-dir
    sudo code --install-extension ms-vscode.vscode-typescript-tslint-plugin --user-data-dir
    sudo code --install-extension ritwickdey.LiveServer --user-data-dir
    sudo code --install-extension streetsidesoftware.code-spell-checker --user-data-dir
    sudo code --install-extension dbaeumer.vscode-eslint --user-data-dir
    sudo code --install-extension vscode-icons-team.vscode-icons --user-data-dir
    sudo code --install-extension Angular.ng-template --user-data-dir
    sudo code --install-extension johnpapa.Angular2 --user-data-dir
    sudo code --install-extension ms-azuretools.vscode-docker --user-data-dir
    sudo code --install-extension mikestead.dotenv --user-data-dir
    sudo code --install-extension codezombiech.gitignore --user-data-dir
    sudo code --install-extension lacroixdavid1.vscode-format-context-menu --user-data-dir
    sudo code --install-extension mhutchie.git-graph --user-data-dir
    sudo code --install-extension tomoki1207.pdf --user-data-dir
    # sudo code --install-extension Shan.code-settings-sync --user-data-dir

    # Set Visual Code Preference
    sudo cp ../.vscode/settings.json $HOME/.config/Code/User/settings.json

    # Install Wallpaper Changer
    sudo add-apt-repository ppa:peterlevi/ppa -y
    sudo apt-get update -q -y
    sudo apt-get install variety variety-slideshow -y

    # Ubuntu 18 Tweaks
    sudo add-apt-repository universe -y
    sudo apt install gnome-tweak-tool -y
    sudo gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action 'cycle-windows'
    # -------------------- Desktop Installation End -------------------- #
fi

# Install Samba (Still you have to update config files.)
sudo apt-get install samba -y
sudo apt-get install system-config-samba -y

# Install Java (Auto Accept Terms)
# sudo apt-get update -q -y
# sudo add-apt-repository ppa:webupd8team/java -y
# sudo apt-get install oracle-java8-installer -y
# javac -version
# java -version

# Install Docker CE
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update -q -y
sudo apt-get install docker-ce -y

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

# Set Access for Current User
# sudo chown $USER:$USER /var/run/docker.sock
sudo usermod -a -G docker "$USER"

# Install Lazydocker
# curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

# Install NVM
curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Install Node
export ENV NODE_VERSION=10.16.3
nvm install $NODE_VERSION

# Install Other Packages
npm install nodemon -g
npm install typescript -g
npm install ts-node -g

# Install Angular CLI
export NG_CLI_ANALYTICS=false
npm install -g @angular/cli@latest --force
ng analytics off

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
end=`date +%s`
# echo "End Time ${end}"
seconds=$((end-start))
echo "Installation has been Completed !"
echo "Total Time Taken In Seconds ${seconds}"
eval "echo $(date -ud "@$seconds" +'%H hours %M minutes %S seconds')"
echo "${reset}"