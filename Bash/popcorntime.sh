#!/bin/bash

# Bash Script to Install Popcorn-Time
# For Mamun(Shanto)
# Works on any GNU/Linux Distro

##################################################
# Don't use it. popcorntime is dead for a while
##################################################

distro() {
	# Distro detector
	# Detects Currently Installed Distribution

	local DISTRO_NAME DISTRO_DATA DISTRO_STR
	# Checking Current Distro
	# cat /etc/*-release | grep "debian" #Outputs ID_LIKE=debian
	for line in `cat /etc/*-release`; do
		if [[ $line =~ ^(NAME|DISTRIB_ID)=(.+)$ ]]; then
			DISTRO_STR=${BASH_REMATCH[2]}
			if echo $DISTRO_STR | grep -qP '(?i).*(ubuntu|mint).*'; then
				DISTRO_NAME='debian'
			elif echo $DISTRO_STR | grep -qP '(?i).*fedora.*'; then
				DISTRO_NAME='fedora'
			elif echo $DISTRO_STR | grep -qP '(?i)^[''"]?(arch|manjaro|antergos|chakra|magpie|parabola|anarchy).*'; then
				DISTRO_NAME='arch'
			fi
			break
		fi
	done
	# plain-arch installation doesn't guarantee /etc/os-release
	# but the filesystem pkg installs a blank /etc/arch-release
	if [ -z "$DISTRO_NAME" ]; then
		if [ -e /etc/arch-release ]; then
		DISTRO_NAME='arch'
		fi
	fi
	echo $DISTRO_NAME
}

install() {
  name="Popcorntime.tar.xz"
  link="https://get.popcorntime.app/repo/build/Popcorn-Time-0.4.5-linux64.zip"

  echo "Downloading the Package..."
  # direct=$(wget -q -O- "$link" | grep -o 'https://[^"]*' | tail -n 22 | grep -o '^https.*zip')
  wget -c "$link" -O "$name"

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
}

echo -e "PopcornTime...\n"
if [[ `distro` == 'debian' ]]; then
  sudo apt-get update -y
  sudo apt-get install -y unzip libcanberra-gtk-module libgconf-2-4 libatomic1
elif [[ `distro` == 'arch' ]]; then
  sudo pacman -Syu --noconfirm
  sudo pacman -S --noconfirm unzip
elif [[ `distro` == 'fedora' ]]; then
  sudo yum update -y
  sudo yum install -y unzip libcanberra-gtk-module libgconf-2-4 libatomic1
fi

install
