#!/usr/bin/sh

# Install TP-Link T4U v3 on Manjaro

# https://archived.forum.manjaro.org/t/install-rtl8812au-dkms-git-driver/52343
# https://aur.archlinux.org/packages/rtl8822bu-dkms-git/


sudo pacman -Syu --noconfirm
sudo pacman -S $(pacman -Qsq "^linux" | grep "^linux[0-9]*[-rt]*$" | awk '{print $1"-headers"}' ORS=' ')
sudo pacman -S dkms bc
git clone -b v5.6.1 https://github.com/fastoe/RTL8812BU.git
cd RTL8812BU
make
sudo make install
sudo modprobe 88x2bu
cd ..
rm -rf RTL8812BU
sudo reboot