#!/bin/bash

# Bash Script to Install Popcorn-Time
# For Mamun(Shanto)
# Works on any GNU/Linux Distro


echo "Updating..."
sudo apt update
echo "Configuring..."
sudo apt install -y libcanberra-gtk-module libgconf-2-4 unzip

name="Popcorntime.zip"
link="https://popcorntime.app/"

echo "Downloading the Package..."
direct=$(wget -q -O- "$link" | grep -o 'https://[^"]*' | tail -n 22 | grep -o '^https.*zip')
wget "$direct" -O "$name"

sudo rm -rf /opt/popcorntime
sudo mkdir -p /opt/popcorntime
# sudo tar -xf popcorntime.tar.xz -C /opt/popcorntime
sudo unzip "$name" /opt/popcorntime

sudo ln -sf /opt/popcorntime/Popcorn-Time /usr/bin/Popcorn-Time

echo "Setting up Desktop Entry..."
echo "[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Name=Popcorn Time
Exec=/usr/bin/Popcorn-Time
Icon=/opt/popcorntime/popcorn.png
Categories=AudioVideo;Player;Recorder;" | sudo tee -a /usr/share/applications/popcorntime.desktop

sudo wget -O /opt/popcorntime/popcorn.png https://upload.wikimedia.org/wikipedia/commons/d/df/Pctlogo.png

rm "$name"

echo "Done!!!"
