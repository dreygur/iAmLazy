#!/bin/bash

: "
    Installs my favourite plugins and theme for VSCode
    To-Do:
        * Support to automatically change theme to my favourite one
        * Support to make VSCODE configured as I like
"

function extensions () {
    # Install required extensions
    # As the cli doesn't take multiple arguments we have to give them repeatedly

    code --install-extension ms-python.python --force # Python Intellisense <3
    code --install-extension octref.vetur --force # VueJS Support inside VSCode
    code --install-extension HookyQR.beautify --force # Install Beautify
    code --install-extension ms-vscode.cpptools --force # Install C/C++ by Microsoft
    code --install-extension dart-code.dart-code --force # Dart Language Support
    code --install-extension dbaeumer.vscode-eslint --force # Javascript Linter
    # code --install-extension oderwat.indent-rainbow --force # Make Indentation awesome!
    code --install-extension xabikos.javascriptsnippets --force # ES6 Snippest
    code --install-extension ritwickdey.liveserver --force # Live Preview for web-designs
    code --install-extension davidanson.vscode-markdownlint --force # Markdown Linting
    code --install-extension eg2.vscode-npm-script --force # nmp Support from VSCode
    code --install-extension felixfbecker.php-debug --force # PHP Debugging
    code --install-extension formulahendry.terminal --force # VSCode Terminal
    code --install-extension anish-m.ci-snippets-2 --force # Snippets for CodeIgniter
    code --install-extension streetsidespftware.code-spell-checker --force # Spell Checker for Code
    code --install-extension slysherz.comment-box --force # Transform Text into a configurable Comment-Box
    code --install-extension wscjava.vscode-java-debug --force # Java Debugger
    code --install-extension mikestead.dotenv --force # Support for dotenc file syntext
    # code --install-extension dart-code.flutter --force # Flutter Support & Debugger
    # code --install-extension kisstkondoros.vscode-gutter-preview --force # Image Preview on Hover
    # code --install-extension vscjava.vscode-java-dependency --force # Manages Java Dependencies
    code --install-extension ionutvmi.path-autocomplete --force # Provides Path Completion
    # code --install-extension wakatime.vscode-wakatime --force # Time Tracking of Programming activity
    # code --install-extension shan.code-settings-sync --force # Synchronizes VSCode Settings on Github
    code --install-extension psioniq.psi-header --force # File-Header Comment Box with Time-Stamp

}

function themes () {
    # Install some themes to make VSCode Eye-Candy
    # As the cli doesn't take multiple arguments we have to give them repeatedly

    code --install-extension Equinusocio.vsc-material-theme --force # Material Theme
    # code --install-extension zhuangtongfa.material-theme --force # Atom's One-Dark material Theme
    # code --install-extension vscode-icons-team.vscode-icons --force # Icons for VSCode
}

function additionals () {
    # Install the dependencies of Installed Extensions

    python3 -m pip install -U pylint --user # Install PyLint
    npm install --global eslint # Install ESLint
}

extensions
themes
additionals