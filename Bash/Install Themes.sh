#!/bin/bash

# This Script somehow can configure my xfce4-de
# as I love to see.
# This is a part of my `iAmLazy` project
# Please push some bug-fix and help me to be lazy as always :)
# Copyrighted under MIT License
# 2019 "Rakibul Yeasin" (@dreygur)
#
# Supports:
#     * Debian
#     * Arch
#     * Fedora
#
# 12:06:2019 05:34:AM WEDNESDAY

# Colorize :D
GREEN='\033[0m\033[1;32m'
RED='\033[0m\033[1;31m'
END='\033[0m'

# Desktop Entry
PLANK_DESKTOP_ENTRY="[Desktop Entry]
Encoding=UTF-8
Version=0.11.4
Type=Application
Name=Plank
Comment=Plank Dock
Exec=/usr/bin/plank
OnlyShowIn=XFCE;
StartupNotify=false
Terminal=false
Hidden=false"

# Banner
echo -e "$GREEN
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
        Theme installer and autoconfig for XFCE4
        This Package installs McOS Dark theme &
        Flat-Remix icon pack on XFCE4
        Also installs Plank as Bottom-Dock

        Support for GNome, KDE, LXDE and Cinnamon
            will be added soon... :)
        
        Bug report: rytotul@yahoo.com
        Github: https://github.com/dreygur/iAmLazy 
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
$END"

function distro () {
    # Distro detector
    # Detects Currently Installed Distribution

    local DISTRO_NAME DISTRO_DATA DISTRO_STR
    # Checking Current Distro
    # cat /etc/*-release | grep "debian" #Outputs ID_LIKE=debian
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
    # plain-arch installation doesn't guarantee /etc/os-release
    # but the filesystem pkg installs a blank /etc/arch-release
    if [ -z "$DISTRO_NAME" ]; then
        if [ -e /etc/arch-release ]; then
        DISTRO_NAME='arch'
        fi
    fi
    echo $DISTRO_NAME
}

function de () {
    # Desktop Environment Detector
    # Till now it doesn't work
    echo 'xfce4'
}

function themes () {
    # Theme installer
    # Need to Implement downloading feature
    # But, the download link is temporary :(
    
    DIR="."

    # Checks if the Script is running from the parent folder or not
    # And then decides to download the required packs or not
    if [[ `pwd` =~ 'Bash' ]]; then
        DIR='../Python/assets'
    elif [[ `pwd` =~ 'iAmLazy' ]]; then
        DIR="./Python/assets"
    else
        # Download Icon-Pack
        wget -O Flat-Remix.tar.xz "https://github.com/dreygur/iAmLazy/raw/master/Python/assets/Flat-Remix.tar.xz"
        # Download xfce4 theme
        wget -O McOS.tar.gz "https://github.com/dreygur/iAmLazy/raw/master/Python/assets/McOS.tar.gz"
        # Downloads Walpaper
        wget -O xubuntu-development.png "https://github.com/dreygur/iAmLazy/raw/master/Python/assets/xubuntu-development.png"
    fi

    if [[ ! -e $HOME/.themes ]]; then
        mkdir $HOME/.themes
    fi

    if [[ ! -e $HOME/.icons ]]; then
        mkdir $HOME/.icons
    fi
    
    if [[ ! -e $HOME/.backdrops ]]; then
        mkdir $HOME/.backdrops
    fi

    # Installs Flat-Remix icon pack
    cp -f $DIR/Flat-Remix.tar.xz $HOME/.icons/
    tar -xf $HOME/.icons/Flat-Remix.tar.xz -C $HOME/.icons/

    # Installs McOS-Dark Theme
    cp -f $DIR/McOS.tar.gz $HOME/.themes/
    tar -xf $HOME/.themes/McOS.tar.gz -C $HOME/.themes/

    # The Walpaper
    cp $DIR/xubuntu-development.png $HOME/.backdrops

    # Clean the Directories
    if [[ $DIR == '.' ]]; then
        rm McOS.tar.gz Flat-Remix.tar.xz xubuntu-development.png
    fi
    rm $HOME/.themes/McOS.tar.gz $HOME/.icons/Flat-Remix.tar.xz
}

function install_plank () {
    # Install Plank

    echo -e "Installing Plank...\n"
    if [[ `distro` == 'debian' ]]; then
        sudo add-apt-repository ppa:ricotz/docky -y
        sudo apt-get update -y
        sudo apt-get install -y plank
    elif [[ `distro` == 'arch' ]]; then
        sudo pacman -Syu plank --noconfirm
    elif [[ `distro` == 'fedora' ]]; then
        sudo yum update -y
        sudo yum install -y plank
    fi

    echo -e "Preparing Plank to autostart...\n"
    sudo tee $HOME/.config/autostart/Plank.desktop <<< "$PLANK_DESKTOP_ENTRY" | grep -v "" # Grep Used for not showing output to stdout
    echo -e "Starting \"Plank\"\n"
    # /usr/bin/plank & disown
    setsid /usr/bin/plank <dev/null &>/dev/null & # Starts the plank executable in a new shell to skip showing outputs to stdout
}

function xfce4_config () {
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
    xfconf-query -c xfce4-desktop --create -p /backdrop/screen0/monitor0/workspace0/last-image -s "/usr/share/xfce4/backdrops/xubuntu-development.png"
    xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-filesystem -s "false"
    xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-removable -s "false"
    xfconf-query -c xfce4-desktop -p /desktop-icons/style -s "2"

    # Configure Panel
    xfconf-query -c xfce4-panel -p /panels/panel-0/position -s "p=6;x=0;y=0"
    xfconf-query -c xfce4-panel -p /panels/panel-0/length -t "uint" -s "100"
    xfconf-query -c xfce4-panel -p /panels/panel-0/position-locked -t "bool" -s "true"

    # Arrange Icons & Reload the Desktop
    xfdesktop --arrange
    xfdesktop --reload
}

echo -e "Hello ${RED}`whoami`${END},\nHow do you feel???\n"

echo -e "Installing GTK3.0 and Icon themes.\nBe patient..."
themes
echo -e "\nThemes installed.\nTweaking your Desktop Environment...\n"

# Installing Plank
install_plank
if [[ `de` == 'xfce4' ]]; then
    xfce4_config
fi

echo -e "\nDone!!!\nCan you please thank me?! :(\n"

echo -e "You better reboot your system now.\nShould I do it for you? [Y/n]\n"
read confirmaton
if [[ ${confirmaton,,} == 'y' ]]; then
    echo -e "Rebooting...\n"
    sleep 3; reboot
fi

# Close the process
exit
