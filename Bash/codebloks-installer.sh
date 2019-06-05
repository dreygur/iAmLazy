#!/usr/bin/bash

: '
    Code::BLocks Installer for Debian/Ubuntu/Linux-Mint
    Author: Rakibul Yeasin
'

install() {
    if [[ -z $( dpkg -l | grep "codeblocks" ) ]]; then
        echo -e "Code::BLocks IDE is not installed...\nInstalling...\n"
        echo -e "Adding PPA..."
        sudo add-apt-repository ppa:damien-moore/codeblocks-stable -y
        echo -e "PPA Added...\nUpdating Cache..."
        sudo apt-get update
        echo -e "Fetching Package from server..."
        sudo apt-get install codeblocks codeblocks-contrib -y

        if [[ -n $( dpkg -l | grep "codeblocks" ) ]]; then
            echo -e "Succesfully installed Code::Blocks IDE..."
        else
            echo -e "Something happend while installing Code::Blocks...\nPlease Retry..."
        fi
    else
        echo "Code::Blocks IDE is already installed..."
    fi
}

install
