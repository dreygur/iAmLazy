#!/bin/sh
# Copyright 2019 the Deno authors. All rights reserved. MIT license.
# TODO(everyone): Keep this script simple and easily auditable.

set -e

if ! command -v curl >/dev/null; then
	echo "Error: curl is required to install go" 1>&2
	exit 1
fi

VERSION=`curl https://go.dev/VERSION?m=text`
go_uri="https://dl.google.com/go/$VERSION.linux-amd64.tar.gz" # linux

go_dir="/usr/local/bin"
go_install="$go_dir/go"
exe="$go_install/bin/go"

if [ ! -d "$go_install" ]; then
	mkdir -p "$go_install"
else
  rm -rf "$go_install"
  mkdir -p "$go_install"
fi

curl --fail --location --progress-bar --output "$go_install.tar.gz" "$go_uri"
tar -C "$go_dir" -xzf "$go_install.tar.gz"
chmod +x "$exe"
rm "$go_install.tar.gz"

echo "Go was installed successfully to $exe"
if command -v go >/dev/null; then
	echo "Run 'go help' to get started"
else
	case $SHELL in
	/bin/zsh) shell_profile=".zshrc" ;;
	*) shell_profile=".bashrc" ;;
	esac
	echo "Manually add the directory to your \$HOME/$shell_profile (or similar)"
	echo "  export GO_INSTALL=\"$go_install\""
	echo "  export PATH=\"\$GO_INSTALL/bin:\$PATH\""
	echo "Run '$exe help' to get started"
fi
echo
echo "Stuck? Join our Discord https://discord.gg/deno"
