#!/usr/bin/sh

#
# Author: Rakibul Yeasin (@dreygur)
#

: "
	Installs my favourite plugins and theme for VSCode
	To-Do:
		* Support to automatically change theme to my favourite one
		* Support to make VSCODE configured as I like
"

# My Fvourite Plugins to use
PLUGINS=(
  # Plugins
  'octref.vetur' \
  'HookyQR.beautify' \
  'ms-vscode.cpptools' \
  'dart-code.dart-code' \
  'dbaeumer.vscode-eslint' \
  'oderwat.indent-rainbow' \
  'xabikos.javascriptsnippets' \
  'ritwickdey.liveserver' \
  'davidanson.vscode-markdownlint' \
  'eg2.vscode-npm-script' \
  'felixfbecker.php-debug' \
  'formulahendry.terminal' \
  'psioniq.psi-header' \
  'ritwickdey.LiveServer' \
  'alexcvzz.vscode-sqlite' \
  'GitHub.copilot' \
  'golang.go' \
  'ms-azuretools.vscode-docker' \
  'ms-python.python' \
  'ms-python.vscode-pylance' \
  'ms-toolsai.jupyter' \
  'ms-vscode.cpptools' \
  # Themse
  'SumitSaha.learn-with-sumit-theme' \
)

# Plugins installer
for i in "${PLUGINS[@]}"; do
  code --install-extension $i --force
done

# Installs PYLINT
if [[ -n $(which python) ]]; then
  python3 -m pip install -U pylint --user
fi

# Installs ESLINT
if [[ -n $(which npm) ]]; then
  npm install --global eslint
elif [[ -n $(which yarn) ]]; then
  yarn global add eslint
else
  echo "Your Computer have to be installed npm/yarn"
fi

# Config File PATH
cp -f vscode_config_file.json $HOME/.config/Code/User/settings.json