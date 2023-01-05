#!/bin/bash
set -e 

#expect for mysql
echo "installing expect"
apt install expect -y 2> error.txt 1>/dev/null

#apache
echo "installing apache"
apt install apache2 -y 2> error.txt 1>/dev/null
systemctl enable apache2 2> error.txt 1>/dev/null
systemctl restart apache2 2> error.txt 1>/dev/null

#apache test
systemctl status apache2 | grep -q "active (running)" && echo "Apache service is running"

#mysql 
echo "installing mysql"
apt install mariadb-server mariadb-client -y 2> error.txt 1>/dev/null
mysql_secure_installation

#php 
echo "installing php"
apt install php php-mysql -y 2> error.txt 1>/dev/null
echo -e "<?php\nphpinfo();\n?>" >/var/www/html/info.php

echo "lamp is up and running"

#wordpress database

echo "settin up wordpress database"
mysql -e "CREATE DATABASE wordpress_db;"
mysql -e "CREATE USER 'wp_user'@'localhost' IDENTIFIED BY 'password';"
mysql -e "GRANT ALL ON wordpress_db.* TO 'wp_user'@'localhost' IDENTIFIED BY 'password';"
mysql -e "FLUSH PRIVILEGES;"
mysql -e "Exit;"

#wordpress cms

echo "installing wordpress"
wget https://wordpress.org/latest.tar.gz -P /tmp 2> error.txt 1>/dev/null
tar -xvf /tmp/latest.tar.gz -C /tmp 2> error.txt 1>/dev/null
cp -R /tmp/wordpress /var/www/html/ 2> error.txt 1>/dev/null
chown -R www-data:www-data /var/www/html/wordpress/ 
chmod -R 755 /var/www/html/wordpress/ 2> error.txt 1>/dev/null
mkdir /var/www/html/wordpress/wp-content/uploads
chown -R www-data:www-data /var/www/html/wordpress/wp-content/uploads/ 

