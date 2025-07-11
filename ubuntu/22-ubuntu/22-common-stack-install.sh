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

# Install essential dependencies
echo "${green}Installing essential dependencies (build-essential, curl, libssl-dev, git)...${reset}"
if ! sudo apt install -y build-essential curl libssl-dev git; then
    echo "${red}Failed to install essential dependencies.${reset}"
    exit 1
fi

# Install Python 3 and related tools
echo "${green}Installing Python 3 and related tools...${reset}"
if ! sudo apt install -y python3-pip python3-dev python3-venv apt-transport-https; then
    echo "${red}Failed to install Python 3 and tools.${reset}"
    exit 1
fi

# Install nvm (Node Version Manager)
echo "${green}Installing nvm...${reset}"
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
if [ $? -eq 0 ]; then
    echo "${green}nvm installed successfully.${reset}"
    # Source nvm for the current session
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
else
    echo "${red}Failed to install nvm.${reset}"
    exit 1
fi

# Install Node.js versions 22 and npm
echo "${green}Installing Node.js versions 22...${reset}"
node_versions=("22")
for version in "${node_versions[@]}"; do
    nvm install "$version"
    if [ $? -eq 0 ]; then
        echo "${green}Node.js $version installed successfully.${reset}"
    else
        echo "${red}Failed to install Node.js $version.${reset}"
        exit 1
    fi
done
# Set default Node.js to latest (22)
nvm alias default 22
nvm use default

# Install MySQL Server and Workbench
echo "${green}Installing MySQL Server...${reset}"
if ! sudo apt update || ! sudo apt install -y mysql-server; then
    echo "${red}Failed to install MySQL Server.${reset}"
    exit 1
fi

echo "${green}Installing MySQL Workbench via Snap...${reset}"
if ! sudo snap install mysql-workbench-community; then
    echo "${red}Failed to install MySQL Workbench via Snap.${reset}"
    exit 1
fi

# Start and secure MySQL
sudo systemctl start mysql
sudo mysql_secure_installation
if command -v mysql >/dev/null 2>&1; then
    echo "${green}MySQL Server installed: $(mysql --version)${reset}"
else
    echo "${red}MySQL Server installation could not be verified.${reset}"
    exit 1
fi
if command -v mysql-workbench-community >/dev/null 2>&1; then
    echo "${green}MySQL Workbench installed.${reset}"
else
    echo "${red}MySQL Workbench installation could not be verified.${reset}"
    exit 1
fi

# Install PostgreSQL
echo "${green}Installing PostgreSQL...${reset}"
if ! sudo apt install -y postgresql postgresql-contrib; then
    echo "${red}Failed to install PostgreSQL.${reset}"
    exit 1
fi
sudo systemctl start postgresql
if command -v psql >/dev/null 2>&1; then
    echo "${green}PostgreSQL installed: $(psql --version)${reset}"
else
    echo "${red}PostgreSQL installation could not be verified.${reset}"
    exit 1
fi

# Install Redis
echo "${green}Installing Redis...${reset}"
if ! sudo apt install -y redis-server; then
    echo "${red}Failed to install Redis.${reset}"
    exit 1
fi
sudo systemctl start redis
if command -v redis-server >/dev/null 2>&1; then
    echo "${green}Redis installed: $(redis-server --version)${reset}"
else
    echo "${red}Redis installation could not be verified.${reset}"
    exit 1
fi

# Install Flameshot
echo "${green}Installing Flameshot...${reset}"
if ! sudo apt install -y flameshot; then
    echo "${red}Failed to install Flameshot.${reset}"
    exit 1
fi
if command -v flameshot >/dev/null 2>&1; then
    echo "${green}Flameshot installed: $(flameshot --version)${reset}"
else
    echo "${red}Flameshot installation could not be verified.${reset}"
    exit 1
fi

# Ensure snapd is running for snap installations
echo "${green}Ensuring snapd service is running...${reset}"
if ! systemctl is-active --quiet snapd; then
    echo "${green}Starting snapd service...${reset}"
    if ! sudo systemctl start snapd; then
        echo "${red}Failed to start snapd service. Cannot proceed with snap installations.${reset}"
        exit 1
    fi
fi
if systemctl is-active --quiet snapd; then
    echo "${green}snapd service is running.${reset}"
else
    echo "${red}snapd service is not running. Cannot proceed with snap installations.${reset}"
    exit 1
fi

# Install Visual Studio Code
echo "${green}Installing Visual Studio Code...${reset}"
if ! sudo snap install code --classic; then
    echo "${red}Failed to install Visual Studio Code.${reset}"
    exit 1
fi
if command -v code >/dev/null 2>&1; then
    echo "${green}Visual Studio Code installed: $(code --version | head -n 1)${reset}"
else
    echo "${red}Visual Studio Code installation could not be verified.${reset}"
    exit 1
fi

# Install Visual Studio Code Extensions
echo "${green}Installing Visual Studio Code extensions...${reset}"
extensions=(
    "Anjali.clipboard-history"
    "streetsidesoftware.code-spell-checker"
    "mikestead.dotenv"
    "EditorConfig.EditorConfig"
    "dbaeumer.vscode-eslint"
    "mhutchie.git-graph"
    "donjayamanne.githistory"
    "xabikos.JavaScriptSnippets"
    "christian-kohler.path-intellisense"
    "esbenp.prettier-vscode"
    "christian-kohler.npm-intellisense"
    "ritwickdey.LiveServer"
    "vscode-icons-team.vscode-icons"
    "ms-azuretools.vscode-docker"
    "codezombiech.gitignore"
    "ms-vscode-remote.remote-containers"
    "redhat.vscode-yaml"
    "alefragnani.project-manager"
    "bradlc.vscode-tailwindcss"
    "GitHub.copilot"
    "eamodio.gitlens"
    "ChakrounAnas.turbo-console-log"
    "Gruntfuggly.todo-tree"
)
for ext in "${extensions[@]}"; do
    if code --install-extension "$ext"; then
        echo "${green}Installed extension: $ext${reset}"
    else
        echo "${red}Failed to install extension: $ext${reset}"
    fi
done

# Install Postman
echo "${green}Installing Postman...${reset}"
if ! sudo snap install postman; then
    echo "${red}Failed to install Postman.${reset}"
    exit 1
fi
if snap list postman >/dev/null 2>&1; then
    echo "${green}Postman installed.${reset}"
else
    echo "${red}Postman installation could not be verified.${reset}"
    exit 1
fi

# Install Slack
echo "${green}Installing Slack...${reset}"
if ! sudo snap install slack --classic; then
    echo "${red}Failed to install Slack.${reset}"
    exit 1
fi
if snap list slack >/dev/null 2>&1; then
    echo "${green}Slack installed.${reset}"
else
    echo "${red}Slack installation could not be verified.${reset}"
    exit 1
fi

# Install AnyDesk
echo "${green}Installing AnyDesk...${reset}"
# Download the GPG key and store it in the correct location
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo gpg --dearmor -o /usr/share/keyrings/anydesk.gpg
if [ $? -ne 0 ]; then
    echo "${red}Failed to download AnyDesk GPG key.${reset}"
    exit 1
fi
# Add the AnyDesk repo with the correct keyring
echo "deb [signed-by=/usr/share/keyrings/anydesk.gpg] http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk.list
# Update apt and install AnyDesk
if ! sudo apt update -y || ! sudo apt install -y anydesk; then
    echo "${red}Failed to install AnyDesk.${reset}"
    exit 1
fi

# Install Google Chrome
echo "${green}Installing Google Chrome...${reset}"
# Download and add the Google Chrome GPG key
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/google-chrome-keyring.gpg
if [ $? -ne 0 ]; then
    echo "${red}Failed to download Google Chrome GPG key.${reset}"
    exit 1
fi
# Add the repository with the correct keyring reference
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
# Update APT and install Google Chrome
if ! sudo apt update -y || ! sudo apt install -y google-chrome-stable; then
    echo "${red}Failed to install Google Chrome.${reset}"
    exit 1
fi
# Verify Google Chrome installed
if command -v google-chrome >/dev/null 2>&1; then
    echo "${green}Google Chrome installed: $(google-chrome --version)${reset}"
else
    echo "${red}Google Chrome installation could not be verified.${reset}"
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

# Fix Wayland issue by switching to X11 for GNOME users
echo "${green}Configuring AnyDesk to work with Wayland...${reset}"

# Force GNOME to use X11 instead of Wayland
if [ -f /etc/gdm3/custom.conf ]; then
    sudo sed -i 's/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf
else
    echo "No custom.conf file found in /etc/gdm3/ to disable Wayland."
    echo "Skipping Wayland disable step."
fi

# Update session manager if necessary
echo "${green}Configuring GDM to use X11...${reset}"
if ! grep -q "WaylandEnable=false" /etc/gdm3/custom.conf; then
    sudo echo "WaylandEnable=false" | sudo tee -a /etc/gdm3/custom.conf
fi

# Reboot to apply changes
echo "${green}Rebooting to apply changes...${reset}"
sudo reboot
