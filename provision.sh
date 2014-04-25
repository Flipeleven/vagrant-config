#!/usr/bin/env bash
 
echo ">>> Starting Install Script"
 
# Update
sudo apt-get update
 
# Install MySQL without prompt
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
 
echo ">>> Installing Base Items"
 
# Install base items
sudo apt-get install -y vim curl wget build-essential python-software-properties
 
echo ">>> Adding PPA's and Installing Server Items"
 
# Add repo for latest PHP
sudo add-apt-repository -y ppa:ondrej/php5
 
# Update Again
sudo apt-get update
 
# Install the Rest
sudo apt-get install -y git-core php5 apache2 libapache2-mod-php5 php5-mysql php5-curl php5-gd php5-mcrypt mysql-server vim php-pear
 
echo ">>> Configuring Server"
 
 
# Apache Config
sudo a2enmod rewrite
wget -O /usr/local/bin/vhost https://gist.github.com/fideloper/2710970/raw/5d7efd74628a1e3261707056604c99d7747fe37d/vhost.sh
sudo chmod guo+x vhost
#sudo mv vhost /usr/local/bin

# Configure Apache to run as vagrant
echo "Setting Apache server name..."
sudo /bin/sh -c \"echo 'ServerName localhost' >> /etc/apache2/apache2.conf\"

sudo service apache2 stop

sed -i -e 's/export APACHE_RUN_USER=www-data/export APACHE_RUN_USER=vagrant/g' /etc/apache2/envvars
sed -i -e 's/export APACHE_RUN_GROUP=www-data/export APACHE_RUN_GROUP=vagrant/g' /etc/apache2/envvars

sudo chown vagrant /var/lock/apache2
sudo service apache2 start

# Enable MySQL query logging
echo "Enabling MySQL query logging to /var/log/mysql/mysql.log"
sed -i -e 's/#general_log_file/general_log_file/g' /etc/mysql/my.cnf
sed -i -e 's/#general_log/general_log/g' /etc/mysql/my.cnf
sudo service mysql restart

#changing ownership
sudo chown vagrant:vagrant /var/www

# PHP Config
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini
 
sudo service apache2 restart
 
# Git Config
curl https://gist.github.com/fideloper/3751524/raw/e576c7b38587d6ab73f47ba901c359496069fc77/.gitconfig > /home/vagrant/.gitconfig
sudo chown vagrant:vagrant /home/vagrant/.gitconfig
 
echo ">>> Installing Composer"
 
# Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# linking shared folders to www
rm -rf /var/www
ln -fs /vagrant_data /var/www




