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