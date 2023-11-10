#!/bin/env sh

# Install the packages
sudo apt install xrdp xserver-xorg-core xserver-xorg-input-all xorgxrdp xfce4 xfce4-goodies -y

# add xrdp into ssl-cert group
sudo adduser xrdp ssl-cert

# Add XFCE4 session to xrdp session
echo "xfce4-session" | tee ~/.xsession

# start xrdp service
sudo systemctl start xrdp

# start xrdp on system start
sudo systemctl enable xrdp


# Now reboot the server
sudo reboot