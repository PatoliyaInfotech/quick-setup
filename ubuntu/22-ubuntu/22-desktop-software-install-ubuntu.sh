#!/usr/bin/env bash
red=`tput setaf 1`
reset=`tput sgr0`
green=`tput setaf 2`

echo "Thank you, we are installting for the Desktop"

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

# -------------------- Desktop Installation Start -------------------- #
# Speed Monitor
# sudo apt-add-repository ppa:fixnix/netspeed -y
# sudo apt-get update -q -y
# sudo apt-get install indicator-netspeed-unity -y

# Install Anydesk
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list
sudo apt update -y
sudo apt install anydesk -y
echo hello@world | sudo anydesk --set-password

# Install Google Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt-get update  -y
sudo apt-get install google-chrome-stable -y

# Install snapd
sudo apt install snapd -y

# Install RocketChat
sudo snap install rocketchat-desktop --classic

# Install Slack
sudo snap install slack --classic

# Install Skype
sudo snap install skype --classic

# Install Postman
sudo snap install postman

# Install Visiul Code
sudo snap install code --classic

# Install Visual Code Extension
sudo code --install-extension monokai.theme-monokai-pro-vscode --user-data-dir
sudo code --install-extension christian-kohler.npm-intellisense --user-data-dir
sudo code --install-extension christian-kohler.path-intellisense --user-data-dir
sudo code --install-extension msjsdiag.debugger-for-chrome --user-data-dir
# sudo code --install-extension EditorConfig.EditorConfig --user-data-dir
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
sudo code --install-extension ms-vscode-remote.remote-containers --user-data-dir
sudo code --install-extension redhat.vscode-yaml --user-data-dir
# sudo code --install-extension Shan.code-settings-sync --user-data-dir

# Set Visual Code Preference
sudo cp ../.vscode/settings.json $HOME/.config/Code/User/settings.json
sudo cp ../.vscode/keybindings.json $HOME/.config/Code/User/keybindings.json

# Install Smartgit
# sudo add-apt-repository ppa:eugenesan/ppa -y
# sudo apt-get update -y
# sudo apt-get install smartgit -y
wget https://www.syntevo.com/downloads/smartgit/smartgit-21_2_3.deb
sudo dpkg -i smartgit-21_2_3.deb -y

# Install Wallpaper Changer
sudo add-apt-repository ppa:peterlevi/ppa -y
sudo apt-get update -q -y
sudo apt-get install variety variety-slideshow -y

# Ubuntu 18 Tweaks
sudo add-apt-repository universe -y
sudo apt install gnome-tweak-tool -y
sudo gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action 'cycle-windows'
# -------------------- Desktop Installation End -------------------- #

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