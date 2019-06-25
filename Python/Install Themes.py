#!/usr/bin/env python3

"""
	This Script somehow can configure my xfce4-de
	as I love to see.
	This is a part of my `iAmLazy` project
	Please push some bug-fix and help me to be lazy as always :)
	@dreygur (Rakibul Yeasin)

	Supports:
		* Debian
		* Arch (Still not)

	22:05:2019 02:41:AM THURSDAY
"""

import sys
import os
import subprocess
import platform as ptm

home = os.environ["HOME"]

def check():
	"""
		Checks Current Platform
		whether it is Debian or Arch based
		Supported Distro's are:
			'SuSE', 'debian', 'fedora', 'redhat',
			'centos', 'mandrake', 'mandriva', 'rocks',
			'slackware', 'yellowdog', 'gentoo',
			'UnitedLinux', 'turbolinux', 'arch',
			'mageia', 'Ubuntu'
	"""

	# Checks Distribution Name
	dist_name = ptm.dist()[0]
	debian = ['debian', 'Ubuntu']
	arch = ['arch']

	if dist_name in debian:
		return 'debian'
	elif dist_name in arch:
		return 'arch'

def update():
	operating_system = check()

	if operating_system == 'debian':
		# Update the system first
		os.system('sudo apt-get -y update') # Updating
		# Then Upgrade to have everything working
		os.system('sudo apt-get -y upgrade') # Upgrading
	elif operating_system == 'arch':
		# Update and upgrade the system first
		os.system('sudo pacman -Syu') # Updating

def themes():
	"""
		Installs GTK and Icon themes on XFCE4
		And tweaks some settings
	"""

	# Update the system first
	update() # Calls the Update Function and does the rest

	# Now try to create theme folder
	if not os.path.exists(home + '/.themes'): # Check if the directory already available or not
		os.makedirs(home + '/.themes') # Creating directory for saving themes file
	if not os.path.exists(home + '/.icons'): # Checks for .icons directory
		os.makedirs(home + '/.icons') # Creates .icons directory

	# Download icon theme
	os.system('cp ../Assets/Flat-Remix.tar.xz ~/.icons/ && tar -xf ~/.icons/Flat-Remix.tar.xz -C ~/.icons/') # Copy and extract the tarball to .icons directory

	# Download xfce4/GTK3 theme
	os.system('cp ../Assets/McOS.tar.gz ~/.themes/ && tar -xf ~/.themes/McOS.tar.gz -C ~/.themes/') # Copy and extract the tarbal to .themes directory

	# Clean Current Working Directory
	os.system('rm ~/.themes/McOS.tar.gz ~/.icons/Flat-Remix.tar.xz')

def config():
	"""
		Configuring XFCE4 to run on user defined settings
	"""

	# Install Plank dock
	if check() == 'debian':
		os.system('sudo add-apt-repository ppa:ricotz/docky -y') # Add the plank ppa to repository list
		os.system('sudo apt-get update -y && sudo apt-get install -y plank') # Update the apt cache and install Plank
	elif check() == 'arch':
		pass
	
	# Plank Desktop Entry
	autostart_plank = ['[Desktop Entry]',
						'Encoding = UTF-8',
						'Version = 0.9.4',
						'Type = Application',
						'Name = Plank',
						'Comment = Plank Dock',
						'Exec = /usr/bin/plank',
						'OnlyShowIn = XFCE;',
						'StartupNotify = false',
						'Terminal = false',
						'Hidden = false'
						]
	# Directory Location
	dr = home + "/.config/autostart/"
	if not os.path.exists(dr):
		os.makedirs(dr)
	plank_location = dr + 'Plank.desktop'
	# Writing File
	if not os.path.exists(plank_location):
		with open(plank_location, "wt") as out:    
			for l in autostart_plank:
				out.write(l+"\n")
	# Plank Done!
	
	# Configure Theme
	os.system('xfconf-query -c xsettings -p /Net/ThemeName -s "McOS-MJV-Dark-XFCE-Edition-2.3"')
	# Configure Icon
	os.system('xfconf-query -c xsettings -p /Net/IconThemeName -s "Flat-Remix-Blue-Dark"')
	# Configure Window manager
	os.system('xfconf-query -c xfwm4 -p /general/theme -s "McOS-MJV-Dark-XFCE-Edition-2.3"')
	os.system('xfconf-query -c xfwm4 -p /general/inactive_opacity -s "100"')
	# Configure Thunar
	os.system('xfconf-query -c thunar -p /last-view -s "ThunarIconView"')
	os.system('xfconf-query -c thunar -p /last-icon-view-zoom-level -s "THUNAR_ZOOM_LEVEL_NORMAL"')
	os.system('xfconf-query -c thunar --create -p /last-location-bar -s "ThunarLocationButtons"')
	# Configure Desktop
	os.system('xfconf-query -c xfce4-desktop --create -p /backdrop/screen0/monitor0/workspace0/last-image -s "/usr/share/xfce4/backdrops/xubuntu-development.png"')
	os.system('xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-filesystem -s "false"')
	os.system('xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-removable -s "false"')
	os.system('xfconf-query -c xfce4-desktop -p /desktop-icons/style -s "2"')
	
	# Configure Panel
	#os.system('xfconf-query -c xfce4-panel --create -p /panels/panel-0 -s "ThunarLocationButtons"') # Ignore it. Don't Uncomment

def main():
	"""
		The traditional main function :)
		Combine all together to work -_-
		Honululu :}
	"""

	try:
		user = subprocess.getoutput('whoami')
		print('Hello {0},\nHow do you feel?\n'.format(user))
		print('Installing GTK3.0 and Icon themes.\nBe patient...')
		themes()
		print('\nThemes installed.\nTweaking your Desktop Environment...')
		config()
		print('\nDone!!!\nCan you please thank me?! :(\n')

	except Exception as e:
		print(e)
		sys.exit()

if __name__ == '__main__':
	main()
