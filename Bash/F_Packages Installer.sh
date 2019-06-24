#!/bin/bash

# Installer for my favourite packages
# of debian based distro.
# Supports:
# 	* Debian
# 	* Arch (Not Yet)
# It's a helper for me
# if i somehow destroy my system (it happens to me)
# Then I would be able to automate the
# boring staffs.
# Author: Rakibul Yeasin (Totul)
# FB: https://www.facebook.com/dreygur

# Colorize :D
GREEN='\033[0m\033[1;32m'
RED='\033[0m\033[1;31m'
END='\033[0m'

# Banner
echo -e "$GREEN
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
	Hello ${USER}, Welcome!!!
	Author: Rakibul Yeasin
	FB: https://www.facebook.com/dreygur
	Github: https://www.github.com/dreygur
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
$END"

function Basic () {
	# Some Basic Operations
	# That is always have to do after fresh installation

	echo -e "Updating the 'System'\n"

	sudo apt-get update -y # Update
	sudo apt-get upgrade -y # Upgrade
	
	# Primary Packages
	echo -e "Installing Primary Packages...\n"
	sudo apt install -y software-properties-common
	sudo apt install -y git git-core # Git
	sudo apt install -y vim gdebi gparted synaptic
	sudo apt install -y curl php5-curl # Curl
	sudo apt install -y gcc g++ # C & C++ Compiler

	# Install QBittorrent(Torrent Client)
	echo -e "Installing QBittorrent...\n"
	sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable -y
	sudo apt-get update -y
	sudo apt-get install qbittorrent -y

	# Installs Libre Office
	echo -e "Installing Libre Office...\n"
	sudo add-apt-repository ppa:libreoffice/ppa -y
	sudo apt-get update -y
	sudo apt install -y fonts-opensymbol libreoffice-avmedia-backend-gstreamer \
				libreoffice-base-core libreoffice-calc libreoffice-common libreoffice-core \
				libreoffice-draw libreoffice-gnome libreoffice-gtk2 libreoffice-help-en-us \
				libreoffice-impress libreoffice-math libreoffice-ogltrans libreoffice-pdfimport \
				libreoffice-style-breeze libreoffice-style-galaxy libreoffice-writer

	# Rhythnbox - Music Player
	echo -e "Installing Rhythnbox...\n"
	sudo add-apt-repository ppa:fossfreedom/rhythmbox -y
	sudo apt-get update -y
	sudo apt install rhythmbox -y

	# Install VLC and VLC-Browser Plugin
	echo -e "Installing VLC and VLC-Browser Plugin...\n"
	sudo apt-get install vlc browser-plugin-vlc -y
}

function Browser() {
	# This Function is for installation of the Browsers I Need

	# Downloads Google Chrome
	echo -e "Installing Google Chrome...\n"
	wget -O Chrome.deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
	# Installing Google Chrome
	sudo dpkg -i Chrome.deb
	sudo apt install -fy # Force Install with dependencies
	rm Chrome.deb # Remove the deb
}

function Editors() {
	# Installs Code Editors I Use

	# Downloads Microsoft Visual Studio Code
	echo -e "Installing Visual Studio Code...\n"
	wget -O vscode.deb "https://go.microsoft.com/fwlink/?LinkID=760868" # Download Deb Package
	# Install vscode
	sudo dpkg -i vscode.deb
	sudo apt install -fy
	rm vscode.deb

	# Installs Sublime Text-3 Stable
	echo -e "Installing Sublime Text-3...\n"
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add - 	# Install the GPG Key
	# Ensure apt is set up to work with https sources
	sudo apt-get install apt-transport-https -y
	# Select the stable channel
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	sudo apt-get update -y
	# Install sublime-text
	sudo apt-get install sublime-text -y
}

function ZSH_Shell() {
	# Installs the required pakages for oh_my_zsh

	# Installs powerlevel9k theme
	git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
	# Download and install powerline font and font configuration
	wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
	wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
	# Move the symbol font to a valid X font path. Valid font paths can be listed with "xset q" 
	mkdir -p ~/.local/share/fonts/
	sudo mv -f PowerlineSymbols.otf ~/.local/share/fonts/
	# Update font Cache
	fc-cache -vf ~/.local/share/fonts/
	# Install the fontconfig file
	mkdir -p ~/.config/fontconfig/conf.d/
	sudo mv -f 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

	# Changing the Default shell from bash to zsh
	chsh -s $(which zsh)
}

echo -e "Installing Basic Aplications...\n"; Basic
echo -e "Installing Browser...\n"; Browser
echo -e "Installing Code Editors...\n"; Editors
echo -e "Installing ZSH Shell...\n"; ZSH_Shell