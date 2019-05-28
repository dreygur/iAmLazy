#!/bin/bash

# Bash Script to Install Popcorn-Time
# For Mamun(Shanto)


echo -e "Updating..."
sudo apt update
echo -e "Configuring..."
sudo apt install libcanberra-gtk-module libgconf-2-4

echo -e "Downloading the Package..."
wget "https://get.popcorntime.sh/build/Popcorn-Time-0.3.10-Linux-64.tar.xz" -O popcorntime.tar.xz

sudo mkdir /opt/popcorntime
sudo tar -xf popcorntime.tar.xz -C /opt/popcorntime

sudo ln -sf /opt/popcorntime/Popcorn-Time /usr/bin/Popcorn-Time

echo -e "Setting up Desktop Entry..."
echo "[Desktop Entry]
Version = 1.0
Type = Multimedia
Terminal = false
Name = Popcorn Time
Exec = /usr/bin/Popcorn-Time
Icon = /opt/popcorntime/popcorn.png
Categories = AudioVideo;Player;Recorder;" | sudo tee -a /usr/share/applications/popcorntime.desktop

sudo wget -O /opt/popcorntime/popcorn.png https://upload.wikimedia.org/wikipedia/commons/d/df/Pctlogo.png

echo "Done!!!"
