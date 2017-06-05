#!/usr/bin/env bash

echo "Provisioning Virtual Machine"

echo "Installing Tomcat"
sudo apt-get -y update >/dev/null 2>&1
sudo apt-get install -y tomcat7 >/dev/null 2>&1
sudo apt-get install -y tomcat7-docs >/dev/null 2>&1
sudo apt-get install -y tomcat7-examples >/dev/null 2>&1
sudo apt-get install -y tomcat7-admin >/dev/null 2>&1
sudo service tomcat7 restart

echo "Preparing MySQL"
sudo apt-get -y update >/dev/null 2>&1
sudo apt-get install -y debconf-utils >/dev/null 2>&1
debconf-set-selections <<< "mysql-server mysql-server/root_password password 1234"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password 1234"
echo "Installing MySQL"
sudo apt-get install -y mysql-server  >/dev/null 2>&1
