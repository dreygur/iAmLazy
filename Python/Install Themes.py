#!/usr/bin/env python3

"""
    This Script somehow can configure my xfce4-de
    as I love to see.
    This is a part of my `iAmLazy` project
    Please push some bug-fix and help me to be lazy as always :)
    @dreygur (Rakibul Yeasin)

    22:05:2019 02:41:AM THURSDAY
"""

import sys
import os


def themes():
    """
        Installs GTK and Icon themes on XFCE4
        And tweaks some settings
    """
    # Update the system first
    os.system('sudo apt update -y') # Updating
    # Then Upgrade to have everything working
    os.system('sudo apt upgrade -y') # Upgrading

    # Now try to create theme folder
    if not os.path.isdir('~/.themes'): # Check if the directory already available or not
        os.system('mkdir ~/.themes') # Creating directory for saving themes file
    if not os.path.isdir('~/.icons'): # Checks for .icons directory
        os.system('mkdir ~/.icons') # Creates .icons directory

    # Download icon theme
    os.system('wget https://dl.opendesktop.org/api/files/download/id/1557303928/s/a877a5254bcaaf6304863462960eba12efc82250f7f08d331de6fc9f4c07d7ebae94c9c0e959af7201d92001a711878006eb23bdbe2448e72e3174d63d0fb5c1/t/1558558998/lt/download/Flat-Remix-Blue-Dark_1.91.tar.xz -O Flat-Remix.tar.xz')
    os.system('cp Flat-Remix.tar.xz ~/.icons/ && tar -xvf ~/.icons/Flat-Remix.tar.xz') # Copy and extract the tarball to .icons directory

    # Download xfce4/GTK3 theme
    os.system('wget https://dl.opendesktop.org/api/files/download/id/1544899311/s/50582968e1b7081cd873c65a5d430f43bfd6017961d64c27c58bcd26a09af878e9b886ae1d483135b11de6ed75aed98c5b5d8248542b2de1e33ccd56b7d4fc3f/t/1558559873/lt/download/McOS-MJV-Dark-XFCE-Edition-2.3.tar.gz -O McOS.tar.gz')
    os.system('cp McOS.tar.gz ~/.themes/ && tar -xvf ~/.themes/McOS.tar.gz') # Copy and extract the tarbal to .themes directory

    # Clean Current Working Directory
    os.system('rm McOS.tar.gz FLat-Remix.tar.xz')

def config():
    """
        Configuring XFCE4 to run on user defined settings
        As xfce4 doesn't have a cli yet I made some configuration files as needed
        The files will be copied to `/home/usr/.config`
    """
    # Before Configuring we should update the apt cache
    os.system('sudo apt update -y')

    # Install Plank dock
    os.system('sudo add-apt-repository ppa:ricotz/docky -y') # Add the plank ppa to repository list
    os.system('sudo apt-get update -y && sudo apt-get install plank -y') # Update the apt cache and install Plank
    
    # Copy xfce4 presets to .config
    os.system('sudo cp -r ./config/xfce4 ~/.config')
    # Copy Plank setting to .config
    os.system('sudo cp -r ./config/plank ~/.config')

def main():
    """
        The traditional main function :)
        Combine all together to work -_-
        Honululu :}
    """

    try:
        print('Hello %s,\nHow do you feel?\n', os.system('whoami'))
        print('Installing GTK3.0 and Icon themes.\nBe patient...')
        themes()
        print('\nThemes installed.\nTweaking your Desktop Environment...')
        config()
        print('\nDone!!!\nCan you please thank me?! :(\n')

    except Exception as e:
        print(e)
        sys.exit()

if __name__ == '__main__':
    main()