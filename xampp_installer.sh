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
        echo -e "No installed environment found.\nInstalling......\n"
        wget -O xampp.run https://www.apachefriends.org/xampp-files/7.2.7/xampp-linux-x64-7.2.7-0-installer.run
        if [[ -e xampp.run ]]; then
            sudo chmod 755 xampp.run
            sudo ./xampp.run
            #rm -rf xampp.run
            if [[ -e /usr/share/xampp.sh ]]; then
                sudo rm /usr/share/xampp.sh
            fi
            sudo cp xampp_installer.sh /usr/share/xampp.sh
            if [[ -e /opt/lampp/etc/httpd.conf ]]; then
                sudo rm /opt/lampp/etc/httpd.conf
                sudo rm /opt/lampp/etc/extra/httpd-vhosts.conf
                sudo cp -f ./XAMPP/httpd.conf /opt/lampp/etc/httpd.conf
                sudo cp -f ./XAMPP/httpd-vhosts.conf /opt/lampp/etc/extra/httpd-vhosts.conf
            fi
            shell=$(echo $SHELL | sed -e 's/\/usr\/bin\///')"rc"
            ttl_dir=$(pwd)
            cp ~/.$shell $d
            sudo echo "alias xmp='/usr/share/xampp.sh'" >> .$shell
            sudo cp -f .$shell ~/.$shell
            echo -e "Installation Complete....\nNext time you can run it bu `xampp 'option'`\n"
        else
            echo -e "Sorry Something went wrong!!!\nTry again...\n"
        fi
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
