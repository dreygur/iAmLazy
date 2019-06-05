#!/usr/bin/bash

#
# This Script somehow can configure my xfce4-de
# as I love to see.
# This is a part of my `iAmLazy` project
# Please push some bug-fix and help me to be lazy as always :)
# @dreygur (Rakibul Yeasin)
#
# 22:05:2019 02:41:AM THURSDAY
#


echo -e "Hello $(whoami),\nHow do you feel?\n"
echo -e "Updating the System..."

# Update the system first
sudo apt update -y # Updating
# Then Upgrade to have everything working
sudo apt upgrade -y # Upgrading

: '
# Now try to create theme folder
if not os.path.isdir('~/.themes'): # Check if the directory already available or not
    os.system('mkdir ~/.themes') # Creating directory for saving themes file
if not os.path.isdir('~/.icons'): # Checks for .icons directory
    os.system('mkdir ~/.icons') # Creates .icons directory
'

echo -e "Installing GTK3.0 and Icon themes.\nBe patient..."

# Download icon theme
cp assets/Flat-Remix.tar.xz ~/.icons/ && tar -xf ~/.icons/Flat-Remix.tar.xz -C ~/.icons/ # Copy and extract the tarball to .icons directory

# Download xfce4/GTK3 theme
cp assets/McOS.tar.gz ~/.themes/ && tar -xf ~/.themes/McOS.tar.gz -C ~/.themes/ # Copy and extract the tarbal to .themes directory

# Clean Current Working Directory
rm ~/.themes/McOS.tar.gz ~/.icons/FLat-Remix.tar.xz

# 
# Configuring XFCE4
# to run on user defined settings
#

echo -e "\nThemes installed.\nTweaking your Desktop Environment..."

# Before Configuring we should update the apt cache
#sudo apt update -y

# Install Plank dock
sudo add-apt-repository ppa:ricotz/docky -y # Add the plank ppa to repository list
sudo apt-get update -y && sudo apt-get install plank -y # Update the apt cache and install Plank

# Configure Theme
xfconf-query -c xsettings -p /Net/ThemeName -s "McOS-MJV-Dark-XFCE-Edition-2.3"
# Configure Icon
xfconf-query -c xsettings -p /Net/IconThemeName -s "Flat-Remix-Blue-Dark"
# Configure Window manager
xfconf-query -c xfwm4 -p /general/theme -s "McOS-MJV-Dark-XFCE-Edition-2.3"
xfconf-query -c xfwm4 -p /general/inactive_opacity -s "100"
# Configure Thunar
xfconf-query -c thunar -p /last-view -s "ThunarIconView"
xfconf-query -c thunar -p /last-icon-view-zoom-level -s "THUNAR_ZOOM_LEVEL_NORMAL"
xfconf-query -c thunar -p /last-location-bar -s "ThunarLocationButtons"
# Configure Desktop
xfconf-query -c xfce4-desktop -p --create /backdrop/screen0/monitor0/workspace0/last-image -s "/usr/share/xfce4/backdrops/xubuntu-development.png"
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-filesystem -s "false"
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-removable -s "false"
xfconf-query -c xfce4-desktop -p /desktop-icons/style -s "2"

# Configure Panel
#xfconf-query -c xfce4-panel -p /panels/panel-0 -s "ThunarLocationButtons" # Ignore it.

echo -e "\nDone!!!\nCan you please thank me?! :(\n"