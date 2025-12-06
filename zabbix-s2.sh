#!/bin/bash

echo "Установка Zabbix Server для server 2"

sudo wget https://repo.zabbix.com/zabbix/7.4/release/debian/pool/main/z/zabbix-release/zabbix-release_latest_7.4+debian12_all.deb
sudo dpkg -i zabbix-release_latest_7.4+debian12_all.deb
sudo apt-get update
sudo apt-get install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent

sudo cp zabbix_server2.conf /etc/zabbix/zabbix_server.conf

echo "Установка и настройка MariaDB для server 2"

sudo apt-get install mariadb-server -y
#sudo mysql -uroot -p1234

#create database zabbix character set utf8mb4 collate utf8mb4_bin;
#create user zabbix@localhost identified by 'password';
#grant all privileges on zabbix.* to zabbix@localhost;
#set global log_bin_trust_function_creators = 0;
#quit;

echo "Настройка Galera для server 2"

sudo systemctl stop mariadb
sudo cp galera2.cnf /etc/mysql/conf.d/galera.cnf

echo "Запуск MariaDB и Zabbix server 2"

sudo systemctl restart mariadb
sudo systemctl restart zabbix-server zabbix-agent apache2
sudo systemctl enable zabbix-server zabbix-agent apache2
