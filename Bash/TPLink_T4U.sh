#!/usr/bin/sh

# Install TP-Link T4U on Manjaro

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm dkms git bc linux-headers-`uname -r`
git clone https://github.com/fastoe/RTL8812BU.git
cd RTL8812BU
VER=$(sed -n 's/\PACKAGE_VERSION="\(.*\)"/\1/p' dkms.conf)
sudo rsync -rvhP ./ /usr/src/rtl88x2bu-${VER}
sudo dkms add -m rtl88x2bu -v ${VER}
sudo dkms build -m rtl88x2bu -v ${VER} --kernelsourcedir
sudo dkms install -m rtl88x2bu -v ${VER}
sudo modprobe 88x2bu
rm -rf RTL8812BU
sudo reboot