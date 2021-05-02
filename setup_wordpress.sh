#!/bin/bash
set -e
echo '################## LEMP Stack Installation ####################'
echo "------------------ Updating APT ------------------"
sudo apt-get -y update && sudo apt-get -y upgrade

echo "------------------ Installing Nginx ------------------"
sudo apt-get -y install nginx

echo "------------------ Configuring Firewall ------------------"
sudo ufw allow 'Nginx Full'

echo "------------------ Installing MYSQL ------------------"
sudo apt-get -y install mysql-server

echo "------------------ Creating WordPress Database ------------------"
mysql_password='QpWo#2LuQ'
debconf-set-selections <<< "mysql-server mysql-server/root_password password $mysql_password"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $mysql_password"

sudo mysql -u root -p$mysql_password << EOF
CREATE DATABASE IF NOT EXISTS wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
CREATE USER IF NOT EXISTS 'wordpressuser'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON wordpress.* to wordpressuser@'localhost';
FLUSH PRIVILEGES;
EOF

echo "------------------ Installing PHP Packages ------------------"
sudo apt-get -y install php-fpm php-mysql php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip
sudo systemctl restart php7.4-fpm

echo "------------------ Configuring SSL Certificate ------------------"
cp /vagrant/nginx-selfsigned.crt /etc/ssl/certs/
cp /vagrant/nginx-selfsigned.key /etc/ssl/private/
cp /vagrant/dhparam.pem /etc/nginx/

echo "------------------ Copying SSL Configurations to Snippet ------------------"
cp /vagrant/self-signed.conf /etc/nginx/snippets/
cp /vagrant/ssl-params.conf /etc/nginx/snippets/

echo "------------------ Creating WordPress Nginx Directory ------------------"
WP_DIR=/var/www/wordpress
if [ ! -d "$WP_DIR" ]; then
    sudo mkdir $WP_DIR
fi

echo "------------------ Copying Nginx Configuration ------------------"
cp /vagrant/nginx_conf /etc/nginx/sites-available/wordpress

echo "------------------ Copying Nginx Index ------------------"
cp /vagrant/index.html /var/www/wordpress/index.html

echo "------------------ Creating Soft Link ------------------"
sudo ln -sf /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/

echo "------------------ Testing Nginx ------------------"
sudo nginx -t

echo "------------------ Restarting Nginx ------------------"
sudo systemctl restart nginx

echo "------------------ Downloading WordPress ------------------"
cd /tmp
WP_FILE=wordpress-5.7.1.tar.gz
if [[ ! -f "$FILE" ]]; then
    curl -LO https://wordpress.org/$WP_FILE
fi

echo "------------------ Extracting WordPress ------------------"
tar xzvf $WP_FILE
sudo cp -a /tmp/wordpress/. $WP_DIR

echo "------------------ Setting Up Privileges ------------------"
sudo chown -R www-data:www-data $WP_DIR

echo "------------------ Copying WordPress PHP Configuration ------------------"
cp /vagrant/wp-config.php /var/www/wordpress/wp-config.php

echo "------------------ Installing WordPress CLI ------------------"
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

cd /var/www/wordpress
echo "------------------ Creating WordPress User ------------------"
wp core install --url="192.168.50.2" --title="WordPress Setup" --admin_user=admin --admin_email=admin@test.com --admin_password="!2three456." --allow-root

echo "------------------ Activating WordPress Theme ------------------"
wp theme install "twentynineteen" --activate --allow-root