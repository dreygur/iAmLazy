#!/bin/bash

# Bash Script to Install Popcorn-Time
# For Mamun(Shanto)


echo "Updating..."
sudo apt update
echo "Configuring..."
sudo apt install -y libcanberra-gtk-module libgconf-2-4

echo "Downloading the Package..."
wget -O popcorntime.tar.xz "https://get.popcorntime.sh/build/Popcorn-Time-0.3.10-Linux-64.tar.xz"

sudo mkdir /opt/popcorntime
sudo tar -xf popcorntime.tar.xz -C /opt/popcorntime

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

rm Popcorn-Time-0.3.10-Linux-64.tar.xz

echo "Done!!!"
