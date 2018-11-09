#!usr/bin/python3

"""
#   Installer for ZSH (Custom)
#   of debian based distro.
#   It's a helper for me
#   if i somehow destroy my system (it happens to me)
#   Then I would be able to automate the
#   boring staffs.
#   Author: Rakibul Yeasin (Totul)
#   FB: https://www.facebook.com/rytotul
#
#   ***Not Licensed***
"""

import sys
from os import system, remove, getcwd
from lsb_release import get_lsb_information
#   TO-DO: Implementaion of LAMP Installation from Maateen of make it myself

class ZSH():
    """ This Class is for installing and configuring zsh shell """

    def install(self):
        # Installs ZSH Shell
        system('sudo apt-get install zsh -y')
        # Changes Default shell to zsh from bash

    def custom_zsh(self):
        #   Installs and customize zsh shell
        _current_directory = getcwd()
        # Downloads and Copies oh-my-zsh plugin
        system('sudo rm -rf ~/.oh-my-zsh')
        system('git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh')
        # Copy the Configuration file to Home Directory
        system('sudo cp ' + _current_directory + '/.zshrc ~/')

    def zsh_fonts(self):
        #   Installs the required pakages for oh_my_zsh
        # Installs powerlevel9k theme
        system('git clone https://github.com/bhilburn/powerlevel9k.git \
                ~/.oh-my-zsh/custom/themes/powerlevel9k')
        # download and install powerline font and font configuration
        system('wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf')
        system('wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf')
        # Move the symbol font to a valid X font path. Valid font paths can be listed with "xset q" 
        system('mkdir -p ~/.local/share/fonts/')
        system('sudo mv -f PowerlineSymbols.otf ~/.local/share/fonts/')
        # Update font Cache
        system('fc-cache -vf ~/.local/share/fonts/')
        # Install the fontconfig file
        system('mkdir -p ~/.config/fontconfig/conf.d/')
        system('sudo mv -f 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/')
    def change_shell(self):
        # Changing the Default shell from bash to zsh
        system('chsh -s $(which zsh)')

if __name__ == '__main__':
    zsh = ZSH()
    zsh.istall()
    zsh.custom_zsh()
    zsh.zsh_fonts()
