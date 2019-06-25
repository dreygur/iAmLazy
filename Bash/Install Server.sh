#!/bin/bash

# Script to install and comnfigure nginx, mariadb, phpmyadmin
# Works only on Debian/Ubuntu

# Global variables
codename="jessie"


function install_nginx() {
    # NGINX
    wget -qO http://nginx.org/keys/nginx_signing.key | sudo apt-key add - # NGINX signing-key
    sudo add-apt-repository -y "deb http://nginx.org/packages/ubuntu/ ${codename} nginx" # Add repo
    sudo apt-get install -y nginx nginx-common nginx-full # Install the packages

    sudo rm -f /etc/nginx/nginx.conf # Remove the default configuration
    sudo cp $(pwd)/Python/nginx/nginx.conf /etc/nginx/nginx.conf # Set pre-defined configuration

    sudo rm -f /etc/nginx/sites-available/default # Remove default configuration file

    cp $(pwd)/Python/nginx/default1 $(pwd)/Python/nginx/default.txt

    # Need to replace `/home/username` with currrent username in `/nginx/default.txt`

    # Set the new settings as default
    sudo mv $(pwd)/nginx/default.txt /etc/nginx/sites-available/default

    # Create /home/username/public_html folder which will
	# be used as NginX web server root directory
    if [[ ! -e ${HOME}/public_html ]]; then
        mkdir ${HOME}/public_html
    fi
}

function install_php() {
    # For php installation

    # add PHP5 ubuntu repo with public key to /etc/apt/sources.list file
    sudo add-apt-repository -y ppa:ondrej/php5-5.6

    # Install the latest stable version of PHP available to the added repo.
    sudo apt-get install -y php5 php5-fpm php5-mysql

    # Edit /etc/php5/fpm/pool.d/www.conf file.
	sudo rm -f /etc/php5/fpm/pool.d/www.conf
	sudo cp $(pwd)/php/www.conf /etc/php5/fpm/pool.d/www.conf

    # Edit /etc/php5/fpm/php.ini file.
	sudo rm -f /etc/php5/fpm/php.ini
	sudo cp $(pwd)/php/php.ini /etc/php5/fpm/php.ini
}

function install_mariadb() {
    # For mariadb installation
    # This method will add MariaDB v10.1 public key to the apt program
    sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db # keyring

    # Add repository
    sudo add-apt-repository -y "deb [arch=amd64,i386] http://mirror.jmu.edu/pub/mariadb/repo/10.1/ubuntu ${codename} main"

    # Install MariaDB v10.1
    sudo apt-get install -y mariadb-server

    # Configuring MariaDB
    sudo mysql_secure_installation # Last Command
}

function install_phpmyadmin() {
    # Install phpmyadmin from ubuntu official repo
    sudo apt-get install -y phpmyadmin
    sudo ln -s /usr/share/phpmyadmin/ ${HOME}/public_html
}

function restart_servers() {
    # Restart Server
    sudo service nginx restart
    sudo service mysql restart
    sudo service php5-fpm restart
}

# Install Common Packages
sudo apt-get install -y software-properties-common

# Install NGINX
echo -e "Installing NGINX...\n"; install_nginx

# Install MariaDB
echo -e "Installing MariaDB...\n"; install_mariadb

# Install PHP-5
echo -e "Installing PHP-5...\n"; install_php

# Install phpMyAdmin
echo -e "Installing phpMyAdmin...\n"; install_phpmyadmin

# Restarting Servers
echo -e "Restarting Servers...\n"; install_phpmyadmin