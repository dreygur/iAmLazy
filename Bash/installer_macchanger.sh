#!/bin/bash

echo -e "\nDownloading Macchanger...\n"
sudo wget https://mirrors.tripadvisor.com/gnu/macchanger/macchanger-1.6.0.tar.gz -O /tmp/macchanger.tar.gz
echo -e "\nDownload Complete...\n"
sudo tar -xvzf /tmp/macchanger.tar.gz -C /tmp/
echo -e "\nInstalling required packages...\n"
sudo apt install build-essential
echo -e "\nConfiguring System...\n"
sudo /tmp/macchanger-*/configure
echo -e "\nMaking Compatible...\n"
sudo make
echo -e "\nInstalling Macchanger...\n"
sudo make install
echo -e "\nInstallation Complete...\n"

echo -e "Clearing out..."
sudo rm -rf /tmp/macchanger-*/ /tmp/macchanger.tar.gz data/ doc/ src/ config.h config.log config.status Makefile stamp-h1
echo -e "\nAll done...\nGood Luck\n"


