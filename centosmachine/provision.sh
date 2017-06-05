#!/usr/bin/env bash

echo "Updating System"
sudo yum install epel-release
sudo yum update -y && sudo reboot

echo "Installing JAVA"
sudo yum install -y java-1.8.0-openjdk-devel

echo "Creating user for Apache Tomcat"
sudo groupadd tomcat
sudo mkdir /opt/tomcat
sudo useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat

cd ~

echo "Download and Install Tomcat"
sudo wget http://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.15/bin/apache-tomcat-8.5.15.tar.gz
sudo tar xvf apache-tomcat-8.5.15.tar.gz -C /opt/tomcat --strip-components=1

cd /opt/tomcat

echo "Setting Permissions"
sudo chgrp -R tomcat conf
sudo chmod -R g+r conf
sudo chmod g+x conf
sudo chown -R tomcat logs/ temp/ webapps/ work/

cd /opt && sudo chown -R tomcat tomcat/

echo "Writing Systemd file"
sudo cat ../../vagrant/sysdfile >> /etc/systemd/system/tomcat.service

echo "Reload daemon"
sudo systemctl daemon-reload
echo "Tomcat Start"
sudo systemctl start tomcat
echo "Enable Tomcat"
sudo systemctl enable tomcat

echo "Tomcat Deployed"


echo "Installing MySQL"

sudo wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
sudo rpm -ivh mysql57-community-release-el7-11.noarch.rpm
sudo yum install -y mysql-server

echo "Start MySQL"
sudo systemctl start mysqld
sudo systemctl enable mysqld

echo "Setting Users"
sudo mysql -e "create user 'mycooluser'@'%' identified by 'mypassword'"
sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'mycooluser'@'%'"
sudo mysql -e "FLUSH PRIVILEGES"

echo "MySQL Installed"
