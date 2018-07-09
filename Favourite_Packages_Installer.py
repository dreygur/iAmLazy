#!usr/bin/python3

"""
#   Installer for my favourite packages
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

class Primary():
    """ This Class is for installation of the primary packages """

    def primary(self):
        #   This will install add-apt-repository
        system('sudo apt install python-software-properties -y')
        update()
        #   Install vim and other primary packages.
        #   Installs Vim, Filezilla, Gdebi, GParted, Synaptic
        system('sudo apt-get install git-core vim filezilla gdebi gparted synaptic curl -y')
    
    def qbittorrent(self):
        #   This will install qBittorrent Stable
        system('sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable')
        update()
        system('sudo apt-get install qbittorrent -y')

    def libre_office(self):
        #   Installs Libre Office
        #   The replacement of Microsoft Office
        system('sudo add-apt-repository ppa:libreoffice/ppa -y')
        update()
        system('sudo apt install fonts-opensymbol libreoffice-avmedia-backend-gstreamer \
                libreoffice-base-core libreoffice-calc libreoffice-common libreoffice-core \
                libreoffice-draw libreoffice-gnome libreoffice-gtk2 libreoffice-help-en-us \
                libreoffice-impress libreoffice-math libreoffice-ogltrans libreoffice-pdfimport \
                libreoffice-style-breeze libreoffice-style-galaxy libreoffice-writer')

class Media():
    """ Class for Media Players """

    def rhythmbox(self):
        #   Rhythnbox - Music Player
        system('sudo add-apt-repository ppa:fossfreedom/rhythmbox -y')
        update()
        system('sudo apt install rhythmbox -y')

    def vlc(self):
        #   VLC - Video Player
        update()
        # Install VLC and VLC - Browser Plugin
        system('sudo apt-get install vlc browser-plugin-vlc -y')

class Browser():
    """ This Class is for installation of the Browsers I Need """

    def chrome(self):
        #   Installs Google Chrome
        system('wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb')
        # Installing Google Chrome
        system('sudo gdebi google-chrome-stable_current_amd64.deb -y')
        remove('google-chrome-stable_current_amd64.deb')
        #update()

    def firefox(self):
        #   Removes Firefox-ESR and installs Firefox Quantum
        # Uninstalls Firefox ESR from Debian/Ubuntu/Mint/Kali
        system('sudo apt remove --purge firefox -y')
        update()
        # Installs Firefox Quantum
        system('sudo apt install firefox -y')

class IDE():
    """ This Class is for installation of the IDE's I Love to use """

    def vscode(self):
        #   Installs Microsoft Visual Stusio Code
        # Download and store GPG Key
        system('curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg')
        # Add repo to sources
        system('sudo mv -f microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg &&\
                sudo sh -c \'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable \
                main" > /etc/apt/sources.list.d/vscode.list\'')
        update()
        # Install vscode
        system('sudo apt-get install code -y')

    def subl(self):
        #   Installs Sublime Text-3 Stable
        # Install the GPG Key
        system('wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -')
        # Ensure apt is set up to work with https sources
        system('sudo apt-get install apt-transport-https -y')
        # Select the stable channel
        system('echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list')
        update()
        # Install sublime-text
        system('sudo apt-get install sublime-text -y')

class ZSH():
    """ This Class is for installing and configuring zsh shell """

    def install(self):
        # Installs ZSH Shell
        system('sudo apt-get install zsh -y')
        # Changes Default shell to zsh from bash
        system('sudo chsh -s $(which zsh)')

    def custom_zsh(self):
        #   Installs and customize zsh shell
        _current_directory = getcwd()
        # Downloads and Copies oh-my-zsh plugin
        system('sudo git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh')
        # Copy the Configuration file to Home Directory
        system('sudo cp ' + _current_directory + ' .zsrch ~/')

    def zsh_fonts(self):
        #   Installs the required pakages for oh_my_zsh
        # Installs powerlevel9k theme
        system('sudo git clone https://github.com/bhilburn/powerlevel9k.git \
                ~/.oh-my-zsh/custom/themes/powerlevel9k')
        # download and install powerline font and font configuration
        system('wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf')
        system('wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf')
        # Move the symbol font to a valid X font path. Valid font paths can be listed with "xset q" 
        system('sudo mv -f PowerlineSymbols.otf ~/.local/share/fonts/')
        # Update font Cache
        system('fc-cache -vf ~/.local/share/fonts/')
        # Install the fontconfig file
        system('mkdir -p ~/.config/fontconfig/conf.d/')
        system('mv -f 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/')

def get_codename():
    #   This function will get the codename of running Distro
    info = get_lsb_information()
    return info['CODENAME']

def update():
    #   This function will download the package lists from the repositories and
    #   "update" them to get information on the newest versions of packages and
    #   their dependencies.
    system('sudo apt-get update')

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
    system('whoami > tmp')
    uname = open('tmp', 'r').read()
    remove('tmp')
    print(text.format(uname[:-1]))

def main():
    #   The main Function
    banner()
    permission = str(input('Are you ready to install??? (Y/n) ')).lower()
    if permission == 'y':
        try:
            print('Installing Primary Packages...\n')
            prm = Primary()
            prm.primary()
            print('Done!\nInstalling "QBittorrent"...')
            prm.qbittorrent()
            print('QBittorrent installed.\nInstalling "Libre Office"')
            #prm.libre_office()
            #print('"Libre Office" installed.')
        except:
            print('Sorry, Something went wrong!\nPrimary Packages Installation Failed.')
        
        try:
            print('Installing Browser...\n')
            brw = Browser()
            print('Installing "Firefox"...')
            brw.firefox()
            print('"Firefox" installed.\nInstalling "Chrome"...')
            brw.chrome()
            print('Done! Browser Installed.')
        except:
            print('Sorry, Something went wrong!\nBrowser Installation Failed.')

        try:
            print('Installing Media Players...')
            mdw = Media()
            print('Installing "VLC Media Player"...')
            mdw.vlc()
            print('"VLC Media Player" installed.\nInstalling "Rhythmbox"...')
            mdw.rhythmbox()
            print('"Rhythbox" installed.')
        except:
            print('Sorry, Something went wrong!\nMedia Player installation Failed.')

        try:
            print('Installing IDE\'s')
            ide = IDE()
            print('Installing "Sublime Text 3 Stable"...')
            ide.subl()
            print('"Sublime Text 3 Stable" installed.\nInstalling "Microsoft VSCode"...')
            ide.vscode()
            print('"Microsoft VSCode" installed.')
        except:
            print('Sorry, Something went wrong!\nIDE installation Failed.')

        try:
            print('Installing ZSH...')
            zsh = ZSH()
            zsh.install()
            zsh.zsh_fonts()
            zsh.custom_zsh()
        except:
            print('Sorry Something went wrong. ZSH Installation or Customization failed.')

        print('Succefully Installed. Enjoy!!!!\nPlease "reboot" the system now.')
        _restart = str(input('Restart now? (Y/n) ')).lower()
        if _restart == 'y':
            system('reboot')
        else:
            print('Exiting...\n')
            sys.exit()
    else:
        print('You Choose to Exit. Exiting....\n')

if __name__ == '__main__':
    main()