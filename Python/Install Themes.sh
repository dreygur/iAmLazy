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

distro () {
    # Distro detector
    # Detects Currently Installed Distribution

    local DISTRO_NAME DISTRO_DATA DISTRO_STR
    # Checking Current Distro
    for line in `cat /etc/*-release`; do
        if [[ $line =~ ^(NAME|DISTRIB_ID)=(.+)$ ]]; then
            DISTRO_STR=${BASH_REMATCH[2]}
            if echo $DISTRO_STR | grep -q ['ubuntu','debian','mint']; then
                DISTRO_NAME='debian'
            elif echo $DISTRO_STR | grep -q ['fedora']; then
                DISTRO_NAME='fedora'
            elif echo $DISTRO_STR | grep -q ['arch','manjaro','antergos','parabola','anarchy']; then
                DISTRO_NAME='arch'
            fi
            break
        fi
    done
    # plain arch installation doesn't guarantee /etc/os-release
    # but the filesystem pkg installs a blank /etc/arch-release
    if [ -z "$DISTRO_NAME" ]; then
        if [ -e /etc/arch-release ]; then
        DISTRO_NAME='arch'
        fi
    fi
    # TODO: if os is not detected, try package-manager detection (not 100% reliable)
    #echo $DISTRO_NAME
}

themes () {
    # Theme installer
    # Need to Implement downloading feature
    # But, the download link is temporary :(

    mkdir $HOME/.themes
    mkdir $HOME/.icons

    # Download Icon-Pack
    # wget -O Flat-Remix.tar.xz
    cp ./Python/assets/Flat-Remix.tar.xz $HOME/.icons/
    tar -xf $HOME/.icons/Flat-Remix.tar.xz -C $HOME/.icons/

    # Download xfce4 theme
    # wget -O McOS.tar.gz
    cp ./Python/assets/McOS.tar.gz $HOME/.themes/
    tar -xf $HOME/.themes/McOS.tar.gz -C $HOME/.themes/
    # Clean the Directory
    rm $HOME/.themes/McOS.tar.gz $HOME/.icons/Flat-Remix.tar.xz
}

install_plank () {
    # Install Plank

    echo "Installing Plank"
    if [ `distro` == 'debian' ]; then
        sudo add-apt-repository ppa:ricotz/docky -y
        sudo apt-get update -y
        sudo apt-get install -y plank
    elif [ `distro` == 'arch' ]; then
        sudo pacman -Syu plank --noconfirm
    fi

    echo "Preparing Plank to autostart..."
    echo "[Desktop Entry]
    Encoding=UTF-8
    Version=0.11.4
    Type=Application
    Name=Plank
    Comment=Plank Dock
    Exec=/usr/bin/plank
    OnlyShowIn=XFCE;
    StartupNotify=false
    Terminal=false
    Hidden=false" | sudo tee -a $HOME/.config/autostart/Plank.desktop
}

config () {
    # Installing Plank
    install_plank

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