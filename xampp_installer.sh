#!/bin/bash

: "
#   XAMPP/LAMPP Server Auto-Installer
#   Author: Totul (fb.com/rytotul)
#   The script is a part of BookBucket Project
#   Use at your own risk
"

lampp="/opt/lampp/lampp"
# read cmd
# Check if lampp is available or not
if [[ $1 == "l" ]]; then
    if [[ -e "$lampp" ]]; then
        # Starts XAMPP Server
        sudo "$lampp" start
    else
        # Downloads and installs XAMPP Server
        # User action needed on GUI
        wget -O xampp.run https://downloadsapachefriends.global.ssl.fastly.net/xampp-files/7.2.7/xampp-linux-x64-7.2.7-0-installer.run
        sudo chmod 755 xampp.run
        sudo ./xampp.run
        rm -rf xampp.run
        sudo cp xampp_installer.sh /usr/share/xampp.sh
        shell=$(echo $SHELL | tr -d /bin/)
        shell+="rc"
        echo "alias xmp='/usr/share/xampp.sh'" > ~/.$shell
    fi
elif [[ $1 == "s" ]]; then
    # Stops XAMPP Server
    sudo "$lampp" stop
elif [[ $1 == "r" ]]; then
    # Re-Starts XAMPP Server
    sudo "$lampp" restart
else
    # Help Message
    echo ""
    echo -e "You have to pass an \"Argument\" in command-line\n"
    echo -e "Help:"
    echo -e "\tTo Start/Launch LAMPP Server pass \"l\" as Argument"
    echo -e "\tTo Stop LAMPP Server pass \"s\" as Argument\n"
    echo -e "\tTo Re-Start LAMPP Server pass \"r\" as Argument\n\n"
fi