#!/bin/bash

# This Script somehow can configure my xfce4-de
# as I love to see.
# This is a part of my `iAmLazy` project
# Please push some bug-fix and help me to be lazy as always :)
# @dreygur (Rakibul Yeasin)
#
# Supports:
#     * Debian
#     * Arch
#
# 05:06:2019 02:41:AM WEDNESDAY


function themes() {
    # Theme installer
    # Need to Implement downloading feature
    # But, the download link is temporary :(

    mkdir $HOME/.themes
    mkdir $HOME/.icons

    # Download Icon-Pack
    # wget -O Flat-Remix.tar.xz
    cp ./Python/assets/Flat-Remix.tar.xz ~/.icons/ && tar -xf ~/.icons/Flat-Remix.tar.xz -C ~/.icons/

    # Download xfce4 theme
    # wget -O McOS.tar.gz
    cp ./Python/assets/McOS.tar.gz ~/.themes/ && tar -xf ~/.themes/McOS.tar.gz -C ~/.themes/
    # Clean the Directory
    rm ~/.themes/McOS.tar.gz ~/.icons/Flat-Remix.tar.xz
}

function config() {
    # Configuring

    # Install Plank
    sudo add-apt-repository ppa:ricotz/docky -y
    sudo apt-get update -y && sudo apt-get install -y plank

    echo "[Desktop Entry]
    Encoding = UTF-8
    Version = 0.9.4
    Type = Application
    Name = Plank
    Comment = Plank Dock
    Exec = /usr/bin/plank
    OnlyShowIn = XFCE;
    StartupNotify = false
    Terminal = false
    Hidden = false" | sudo tee -a $HOME/.config/autostart/PLank.desktop

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
    xfconf-query -c thunar --create -p /last-location-bar -s "ThunarLocationButtons"
    
    # Configure Desktop
    xfconf-query -c xfce4-desktop --create -p /backdrop/screen0/monitor0/workspace0/last-image -s "/usr/share/xfce4/backdrops/xubuntu-development.png"
    xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-filesystem -s "false"
    xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-removable -s "false"
    xfconf-query -c xfce4-desktop -p /desktop-icons/style -s "2"
}


echo -e "Hello `whoami`,\nHow do you feel???\n"
echo -e "Installing GTK3.0 and Icon themes.\nBe patient..."
themes
echo -e "\nThemes installed.\nTweaking your Desktop Environment..."
config
echo -e "\nDone!!!\nCan you please thank me?! :(\n"