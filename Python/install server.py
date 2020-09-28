#!/usr/bin python3

from os import environ, getcwd, mkdir, system
from apt import Cache

def get_codename():
	return "focal"

class NginX():

	"""This class will define several methods which will interact with NginX."""

	def add_key(self, current_working_directory):
		# This method will add NginX signing key to the apt program keyring.
		#system("wget http://nginx.org/keys/nginx_signing.key")
		system("sudo apt-key add "+current_working_directory+"/nginx/nginx_signing.key")

	def add_repo(self):
		# This method will add stable NginX ubuntu repo to
		# /etc/apt/sources.list file.
		codename = get_codename()
		system(
			"sudo add-apt-repository -y \"deb http://nginx.org/packages/ubuntu/ " + codename + " nginx\"")

	def install_nginx(self):
		# This method will install the latest stable version of NginX available
		# to the added repo.
		system("sudo apt-get install -y nginx nginx-common nginx-full")

	def edit_nginx_conf_file(self, current_working_directory):
		# This method will edit /etc/nginx/nginx.conf file.
		system("sudo rm -f /etc/nginx/nginx.conf")
		system("sudo cp " + current_working_directory +
				"/nginx/nginx.conf /etc/nginx/nginx.conf")

	def edit_nginx_default_file(self, current_working_directory, **choice):
	# This method will edit /etc/nginx/sites-available/default file.
		home_directory = environ['HOME']
		system("sudo rm -f /etc/nginx/sites-available/default")
		if choice['php'] == 'y':
			default = 'default1'
		else:
			default = 'default2'
		system("cp " + current_working_directory + "/nginx/"+default+" " +
			   current_working_directory + "/nginx/default.txt")
		with open(current_working_directory + "/nginx/default.txt", "r") as file:
			contents = file.read()
		with open(current_working_directory + "/nginx/default.txt", "w") as file:
			if "/home/username" in contents:
				final_contents = contents.replace(
					"/home/username", home_directory)
			else:
				final_contents = contents
			file.write(final_contents)
		system("sudo mv " + current_working_directory +
			   "/nginx/default.txt /etc/nginx/sites-available/default")


	def create_web_server_root_directory(self, current_working_directory):
		# This function will create /home/username/public_html folder which will
		# be used as NginX web server root directory
		home_directory = environ['HOME']
		try:
			mkdir(home_directory + "/public_html")
		except FileExistsError:
			print(home_directory +
				"/public_html\' folder already exists.")


class MariaDB():

	"""This class will define several methods which will interact with MariaDB"""

	def add_key(self):
		# This method will add MariaDB v10.1 public key to the apt program
		# keyring.
		system(
			"sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db")

	def add_repo(self):
		# This method will add MariaDB v10.1 ubuntu repo to
		# /etc/apt/sources.list file.
		codename = get_codename()
		system(
			"sudo add-apt-repository -y \"deb [arch=amd64,i386] http://mirror.jmu.edu/pub/mariadb/repo/10.1/ubuntu " + codename + " main\"")

	def install_mariadb(self):
		# This method will install MariaDB v10.1.
		system("sudo apt-get install -y mariadb-server")


class PHP():

	"""This class will define several methods which will interact with PHP."""

	def add_repo(self):
		# This method will add PHP5 ubuntu repo with public key to
		# /etc/apt/sources.list file.
		codename = get_codename()
		system("sudo add-apt-repository -y ppa:ondrej/php5-5.6")

	def install_php(self):
		# This method will install the latest stable version of PHP available
		# to the added repo.
		system("sudo apt-get install -y php5 php5-fpm php5-mysql")

	def edit_php_fpm_www_conf_file(self, current_working_directory):
		# This method will edit /etc/php5/fpm/pool.d/www.conf file.
		system("sudo rm -f /etc/php5/fpm/pool.d/www.conf")
		system("sudo cp " + current_working_directory +
			   "/php/www.conf /etc/php5/fpm/pool.d/www.conf")

	def edit_php_ini_file(self, current_working_directory):
		# This method will edit /etc/php5/fpm/php.ini file.
		system("sudo rm -f /etc/php5/fpm/php.ini")
		system("sudo cp " + current_working_directory +
			   "/php/php.ini /etc/php5/fpm/php.ini")

def get_user_choice():
	# This function will hold the user choice
	choice = {}  # A dictionary, will contain user choice
	print("Welcome to Easy_LEMP!")
	print("Please let Easy_LEMP know your choice.")
	choice['nginx'] = input("Do you want Easy_LEMP to install NginX? (y/n): ")
	choice['mariadb'] = input(
		"Do you want Easy_LEMP to install MariaDB? (y/n): ")
	choice['php'] = input("Do you want Easy_LEMP to install PHP? (y/n): ")
	choice['phpmyadmin'] = input(
		"Do you want Easy_LEMP to install phpMyAdmin? (y/n): ")
	return choice


def install_phpmyadmin():
	# This function will install phpMyAdmin
	home_directory = environ['HOME']
	system("sudo apt-get install -y phpmyadmin")
	system("sudo ln -s /usr/share/phpmyadmin/ " +
		   home_directory + "/public_html")


def restart_server():
	# This function will restart NginX, MariaDB, PHP5-FPM if installed.
	cache = Cache()
	if cache['nginx'].is_installed:
		system("sudo service nginx restart")
		if cache['mariadb-server'].is_installed:
			system("sudo service mysql restart")
			if cache['php5-fpm'].is_installed:
				system("sudo service php5-fpm restart")
			else:
				print("PHP isn't installed. So, it hasn't been started.")
		else:
			print("MariaDB isn't installed. So, it hasn't been started.")
	elif cache['mysql'].is_installed:
		system("sudo service mysql restart")
		if cache['php5-fpm'].is_installed:
				system("sudo service php5-fpm restart")
		else:
			print("PHP isn't installed. So, it hasn't been started.")
	else:
		system("sudo service php5-fpm restart")


def update_package_lists():
	# This function will downloads the package lists from the repositories and
	# "updates" them to get information on the newest versions of packages and
	# their dependencies.
	system("sudo apt-get update")


def main():
	# Defining the main function regarding Easy_LEMP.
	current_working_directory = getcwd()
	choice = get_user_choice()
	if choice['nginx'] == 'y' or choice['mariadb'] == 'y' \
			or choice['php'] == 'y' or choice['phpmyadmin'] == 'y':
		system("sudo apt-get install -y software-properties-common")

		if choice['nginx'] == 'y' and choice['mariadb'] == 'y' \
				and choice['php'] == 'y' and choice['phpmyadmin'] == 'y':
			# Installing NginX, MariaDB, PHP with regarding Class and methods.
			nginx = NginX()
			mariadb = MariaDB()
			php = PHP()
			nginx.add_key(current_working_directory)
			nginx.add_repo()
			mariadb.add_key()
			mariadb.add_repo()
			php.add_repo()
			update_package_lists()
			nginx.install_nginx()
			mariadb.install_mariadb()
			php.install_php()

			# Creating web server root directory.
			nginx.create_web_server_root_directory(current_working_directory)

			# Editing /etc/nginx/nginx.conf file.
			#nginx.edit_nginx_conf_file(current_working_directory)

			# Editing /etc/nginx/sites-available/default file.
			nginx.edit_nginx_default_file(current_working_directory, **choice)

			# Editing /etc/php5/fpm/php.ini file.
			#php.edit_php_ini_file(current_working_directory)

			# Editing /etc/php5/fpm/pool.d/www.conf file.
			#php.edit_php_fpm_www_conf_file(current_working_directory)

			# Configuring MariaDB.
			system("sudo mysql_secure_installation")

			# Installing phpMyAdmin.
			install_phpmyadmin()

			# Restarting NginX, MariaDB, PHP5-FPM.
			restart_server()
		else:
			# Installing NginX only.
			if choice['nginx'] == 'y':
				nginx = NginX()
				nginx.add_key(current_working_directory)
				nginx.add_repo()
				update_package_lists()
				nginx.install_nginx()
				# Creating web server root directory.
				nginx.create_web_server_root_directory(current_working_directory)
				# Editing /etc/nginx/nginx.conf file.
				nginx.edit_nginx_conf_file(current_working_directory)
				# Editing /etc/nginx/sites-available/default file.
				nginx.edit_nginx_default_file(current_working_directory, **choice)

			# Installing MariaDB only
			elif choice['mariadb'] == 'y':
				mariadb = MariaDB()
				mariadb.add_key()
				mariadb.add_repo()
				update_package_lists()
				mariadb.install_mariadb()
				# Configuring MariaDB
				system("sudo mysql_secure_installation")

			# Installing PHP only.
			elif choice['php'] == 'y':
				php = PHP()
				php.add_repo()
				php.install_php()
				# Editing /etc/php5/fpm/php.ini file.
				php.edit_php_ini_file(current_working_directory)
				# Editing /etc/php5/fpm/pool.d/www.conf file.
				php.edit_php_fpm_www_conf_file(current_working_directory)

			# Installign phpMyAdmin only.
			else:
				install_phpmyadmin()

		# Restarting NginX, MariaDB, PHP5-FPM if installed
		restart_server()

	else:
		print("Oops! It seems that you don't wanna install anything.")

if __name__ == "__main__":
	main()
