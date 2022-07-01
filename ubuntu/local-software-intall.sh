#!/usr/bin/env bash
red=`tput setaf 1`
green=`tput setaf 2`
magenta=`tput setaf 6`
reset=`tput sgr0`

archiveFiles=$(find ./Archive/Files/ -name "*.gz")
#echo ${archiveFiles}
for filePath in $archiveFiles
do
    echo "\n"
    echo "${magenta}"
    echo "Start UnArchiving ${filePath}"
    echo "${reset}"
    echo "$(tar -xvzf ${filePath} -C $HOME)"
    echo "${green}"
    echo "Complete UnArchiving  ${filePath}"
    echo "${reset}"
done

debFiles=$(find ./Debian/Files/ -name "*.deb")
#echo ${debFiles}
for filePath in $debFiles
do
    echo "\n"
    echo "${green}"
    echo "Start Installing ${filePath}"
    echo "${reset}"
    echo $(sudo dpkg -i $filePath)
    echo "\n"
    echo "${green}"
    echo "Complete Installing ${filePath}"
    echo "${reset}"
done

# Install DEB file and fix Broken Package
sudo apt-get install -f -y

# Clean apt Cached packages
sudo apt-get autoclean -y

# Upgrade to Latest Update
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y