#!/usr/bin/env bash

: "
#   Git updater for Linux
#   Modified by: Nazmul Hossain (fb.com/nazmul.XI)
"

function main {
    echo
    echo "[*] Done...Initializing who am I."
    git config user.email "rytotul@gmail.com"
    git config user.name "Totul"

    # Check whether it is already a git repo or not
    if [[ -e ".git" ]]; then
        echo "[*] Already a git repo..."
    else
        echo "[*] Done...Initializing a new Git repo for this project."
        echo
        git init
    fi

    # Add new files if there any
    echo
    echo "[*] Done...Saving changes to the repository."
    git add .

    # Commit Changes
    # TO HACK COMMIT JUST COMMENT OUT #1 AND PLACE YOUR COMMIT INSTEAD OF $message
    echo "[*] Done...Committing a modified version of a file to the repo."
    echo
    read -p "[*] Add commit message: " message #1
    git commit -am "$message"

    # List your existing remotes in order to get the name of the remote you want to change.
    echo
    echo "[*] Checking remote origin."
    repo=$(git remote -v)

    # Checks the repository avaibility
    if [[ $repo == "" ]]; then
        echo -e "[-] No remote repository added.\n[-] Add Some..."
    else
        echo "[*] Remote repository found!"
    fi

    # Push the local changes to remote
    echo
    echo "[*] Pushing local codebase to remote repo...Repo-to-repo collaboration."
    #git push origin master
    git push --all -f
}

function update {
    # List your existing remotes in order to get the name of the remote you want to change.
    echo
    echo "[*] Checking remote origin."
    repo=$(git remote -v)
    
    # Changes the remote's URL.
    echo
    read -p "[+] The new repo URL: " n_repo
    echo "[*] Done...Updating remote URL."
    git remote set-url origin $n_repo
    
    # Verify that the remote URL has changed.
    echo "[*] Done...Verifying remote URL."
    repo2=$(git remote -v)
    if [[ $repo == $repo2 ]]; then
        echo -e "[*] Repo's are same...\n"
    else
        echo -e "[*] Repo Updated!\n"
    fi
}

# Help Message
function help {
    echo "[+] Pass 'u' as an argument to update the remote URL"
    echo "[+] Pass 'h' or '-h' for 'help'"
    echo "[+] TO HACK COMMIT JUST COMMENT OUT #1 AND PLACE YOUR COMMIT INSTEAD OF $message"
}

# Here the Scripts Starts
if [[ $1 == 'h' || $1 == '-h' ]]; then
    help
elif [[ $1 == "u" ]]; then
    update
elif [[ $1 == "" ]]; then
    main
else
    echo "[-] Nothing Understood..."
    echo "[-] Pass 'h' for 'Help'"
fi
