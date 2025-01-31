#!/bin/bash

#############################################################
#                                                                                  
# NAME: webserver_ubuntu.sh                                 #
#                                                           #
# Modified by: Vilas Varghese           					#
#                                                           #
# DESCRIPTION: This script installs the LAMP stack        	#
#                                                           #
# USAGE: ./webserver_ubuntu.sh                              #
#############################################################

function main_menu () {
	clear
	echo " "
	echo "LAMP Stack Ubuntu $0"
	echo " "
	echo "Choose an option below to begin!

		1 - Install Apache on the system
		2 - Install MariaDB database on the system
		3 - Install PHP 7.2 on the system
		4 - Install the complete LAMP stack on the system
		0 - Exit the installation menu"
echo " "
echo -n "Option chosen: "
read option
case $option in
	1)
		function install_apache () {
		TIME=2
			echo "Updating your system..."
			sleep $TIME
			apt update && apt upgrade -y
			echo "Start apache installation on ubuntu..." 
			sleep $TIME
			#sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT
			#sudo ufw allow http
			#sudo chown www-data:www-data /var/www/html/ -R
			apt install -y apache2 apache2-utils
			sudo systemctl start apache2
			sudo systemctl enable apache2	
			echo " "
				if [ $? -eq 0 ] 
				then
					echo "Apache has been installed on your system."
				else
					echo "Oops, some error occurred, let's try again!"
				fi
			}
			install_apache
			read -n 1 -p "<Enter> for main menu"
			main_menu
	;;

	2)
		function install_mariadb () {
		TIME=2
			echo "Starting MariaDB installation..."
			sleep $TIME
			sudo apt -y install mariadb-server mariadb-client
			sudo systemctl start mariadb
			sudo systemctl enable mariadb
				if [ $? -eq 0 ]
				then
					echo "Now let's configure the database..."
					sleep $TIME
					sudo mysql_secure_installation
					echo " "
					echo "Great, congratulations, the database was installed and configured!"
					sleep $TIME
				else
					echo "Oops, let's fix this? I think something went wrong."
				fi
			}
			install_mariadb
			read -n 1 -p "<Enter> for main menu"
			main_menu
	;;

	3)
		function install_php () {
			echo "Starting PHP installation..."
			sudo apt install -y php7.2 libapache2-mod-php7.2 php7.2-mysql php-common php7.2-cli php7.2-common php7.2-json php7.2-opcache php7.2-readline
			sudo a2enmod php7.2
			sudo systemctl restart apache2	
			echo " "
			echo "PHP 7.2 has been installed, that's great!"
			#To test the installed PHP...
			#sudo vim /var/www/html/info.php <?php phpinfo(); ?>
			}
			install_php
			read -n 1 -p "<Enter> for main menu"
			main_menu
	;;

	4)
		function install_lamp () {
		TIME=2	
			#apache
			echo "Let's start the installation of the LAMP stack on your system..." 
			sleep $TIME
			echo "Installing Apache..."
			sleep $TIME
			apt install -y apache2 apache2-utils
			sudo systemctl start apache2
			sudo systemctl enable apache2
			echo "Installing the database..."
			sleep $TIME
			#database
			sudo apt -y install mariadb-server mariadb-client
			sudo systemctl start mariadb
			sudo systemctl enable mariadb
			#PHP
			echo "Installing PHP..."
			sleep $TIME
			sudo apt install -y php7.2 libapache2-mod-php7.2 php7.2-mysql php-common php7.2-cli php7.2-common php7.2-json php7.2-opcache php7.2-readline
			sudo a2enmod php7.2
			sudo systemctl restart apache2
			echo "Installation completed successfully!"
			sleep $TIME
		}
			install_lamp
			read -n 1 -p "<Enter> for main menu"
			main_menu
	;;

	0)
		function exit_system () {
			TIME=2
			echo " "
			echo "Exiting the system..."
			sleep $TIME
			exit 0
		}
		exit_system
	;;

esac
}
main_menu