#!/usr/bin/python3

"""
#   Installer for my favourite packages
#   on Termux on Android.
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

class ZSH():
    """ This Class is for installing and configuring zsh shell """

    def install(self):
        # Installs ZSH Shell
        system('pkg install zsh -y')
        # Changes Default shell to zsh from bash

    def custom_zsh(self):
        #   Installs and customize zsh shell
        _current_directory = getcwd()
        # Install termux-zsh
        system('git clone https://github.com/rytotul/termux-zsh/.git "$HOME/termux-ohmyzsh" --depth 1')
        system('mv "$HOME/.termux" "$HOME/.termux.bak.$(date +%Y.%m.%d-%H:%M:%S)"')
        system('cp -R "$HOME/termux-zsh/.termux" "$HOME/.termux"')
        # Downloads and Copies oh-my-zsh plugin
        system('git clone git://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh" --depth 1')
        system('mv "$HOME/.zshrc" "$HOME/.zshrc.bak.$(date +%Y.%m.%d-%H:%M:%S)"')
        system('cp "$HOME/.oh-my-zsh/templates/zshrc.zsh-template" "$HOME/.zshrc"')
        system('sed -i \'/^ZSH_THEME/d\' "$HOME/.zshrc"')
        # Copy the Configuration file to Home Directory
        system('sed -i \'1iZSH_THEME="agnoster"\' "$HOME/.zshrc"')
        # I will implement these later
        #system('echo "alias chcolor=\'$HOME/.termux/colors.sh\'" >> "$HOME/.zshrc"')
        #system('echo "alias chfont=\'$HOME/.termux/fonts.sh\'" >> "$HOME/.zshrc"')
        system('git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" --depth 1')
        system('echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"')

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
        system('mv -f PowerlineSymbols.otf ~/.local/share/fonts/')
        # Update font Cache
        system('fc-cache -vf ~/.local/share/fonts/')
        # Install the fontconfig file
        system('mkdir -p ~/.config/fontconfig/conf.d/')
        system('mv -f 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/')
    def change_shell(self):
        # Changing the Default shell from bash to zsh
        system('chsh -s zsh)')

def update():
    #   This function will download the package lists from the repositories and
    #   "update" them to get information on the newest versions of packages and
    #   their dependencies.
    system('pkg update')

def banner():
    #   Banner for the script
    text = """
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    \tHello {0}, Welcome!!!
    \tAuthor: Rakibul Yeasin (Totul)
    \tFB: https://www.facebook.com/rytotul
    \tGithub: https://www.github.com/rytotul
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    """
    """ 
    system('whoami > tmp')
    uname = open('tmp', 'r').read()
    remove('tmp') """
    try:
        uname = system('grep "^${USER}:" /etc/passwd | cut -d: -f5')
        print(text.format(uname))
    except:
        print(text.format("Android"))

def main():
    #   The main Function
    banner()
    permission = str(input('Are you ready to install??? (Y/n) ')).lower()
    if permission == 'y':
        try:
            print('Installing ZSH...')
            zsh = ZSH()
            zsh.install()
            zsh.custom_zsh()
            #zsh.zsh_fonts()
            zsh.change_shell()
        except :
            print('Sorry Something went wrong. ZSH Installation or Customization failed.')

        print('Succefully Installed. Enjoy!!!!\nPlease "reboot" the system now.')
    else:
        print('You Choose to Exit. Exiting....\n')

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print("You choose to exit.\nExiting...")
        sys.exit()
