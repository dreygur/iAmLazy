#/usr/bin/env python3

"""
    Installs my favourite plugins and theme for VSCode
    To-Do:
        * Support to automatically change theme to my favourite one
        * Support to make VSCODE configured as I like
"""

# Import
from os import system as c

# Function to Install the necessay plugins
def install():
    cmd = 'code --install-extension --force ' # Common part of the installation command

    """
        Plugins
    """
    c(cmd + 'ms-python.python') # Python Intellisense <3
    c(cmd + 'octref.vetur') # VueJS Support inside VSCode
    c(cmd + 'HookyQR.beautify') # Install Beautify
    c(cmd + 'ms-vscode.cpptools') # Install C/C++ by Microsoft
    c(cmd + 'dart-code.dart-code') # Dart Language Support
    c(cmd + 'dbaeumer.vscode-eslint') # Javascript Linter
    c(cmd + 'oderwat.indent-rainbow') # Make Indentation awesome!
    c(cmd + 'xabikos.javascriptsnippets') # ES6 Snippest
    c(cmd + 'ritwickdey.liveserver') # Live Preview for web-designs
    c(cmd + 'davidanson.vscode-markdownlint') # Markdown Linting
    c(cmd + 'eg2.vscode-npm-script') # nmp Support from VSCode
    c(cmd + 'felixfbecker.php-debug') # PHP Debugging
    c(cmd + 'formulahendry.terminal') # VSCode Terminal

    """
        Themes
    """
    c(cmd + 'Equinusocio.vsc-material-theme') # Material Theme

def main():
    """
        THe main Function of this useless Script.
        You may not like/love this but it will help you definitely.
        Love from Ralibul
    """
    install()

if __name__ == '__main__':
    main()