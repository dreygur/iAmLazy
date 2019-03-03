#!/usr/bin/env python3

"""
    Installs my favourite plugins and theme for VSCode
    To-Do:
        * Support to automatically change theme to my favourite one
        * Support to make VSCODE configured as I like
"""

# Import
import sys
import time
from os import system as c

# Function to Install the necessay plugins
def install():
    cmd = 'code --install-extension ' # Common part of the installation command
    f = ' --force'

    """
        Plugins
    """
    c(cmd + 'ms-python.python' + f) # Python Intellisense <3
    c(cmd + 'octref.vetur' + f) # VueJS Support inside VSCode
    c(cmd + 'HookyQR.beautify' + f) # Install Beautify
    c(cmd + 'ms-vscode.cpptools' + f) # Install C/C++ by Microsoft
    c(cmd + 'dart-code.dart-code' + f) # Dart Language Support
    c(cmd + 'dbaeumer.vscode-eslint' + f) # Javascript Linter
    c(cmd + 'oderwat.indent-rainbow' + f) # Make Indentation awesome!
    c(cmd + 'xabikos.javascriptsnippets' + f) # ES6 Snippest
    c(cmd + 'ritwickdey.liveserver' + f) # Live Preview for web-designs
    c(cmd + 'davidanson.vscode-markdownlint' + f) # Markdown Linting
    c(cmd + 'eg2.vscode-npm-script' + f) # nmp Support from VSCode
    c(cmd + 'felixfbecker.php-debug' + f) # PHP Debugging
    c(cmd + 'formulahendry.terminal' + f) # VSCode Terminal

    """
        Themes
    """
    c(cmd + 'Equinusocio.vsc-material-theme') # Material Theme

def configure():
    """
        Finding out the way to configure easily.
        Till then this function is useless.
        * Have a nice cup of coffee in your dream!
    """
    pass

def main():
    """
        THe main Function of this useless Script.
        You may not like/love this but it will help you definitely {or tear-down you :) }.
        Love from Ralibul
    """
    try:
        install()
        configure()
    except KeyboardInterrupt:
        print('You killed me :( ')
        sys.exit(1)
    except IOError:
        print('You\'re not connected to internet.\nTry to connect.\nI\'m retrying after 3 seconds...')
        time.sleep(3)
        install()
        configure()
    except IndentationError:
        print('Kill the developer...\nHe missed indentation in \'Pyton\'')
        sys.exit(1)

    sys.exit(0)

if __name__ == '__main__':
    main()