#!/bin/bash

echo "Установка Zabbix Server для server 2"

sudo wget https://repo.zabbix.com/zabbix/7.4/release/debian/pool/main/z/zabbix-release/zabbix-release_latest_7.4+debian12_all.deb
sudo dpkg -i zabbix-release_latest_7.4+debian12_all.deb
sudo apt-get update
sudo apt-get install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent

cd ~/zabbix-deployment/
sudo cp zabbix_server2.conf /etc/zabbix/zabbix_server.conf

echo "Установка и настройка MariaDB для server 2"

sudo apt-get install rsync mariadb-server galera-4 -y

echo "Настройка Galera для server 2"

sudo systemctl stop mariadb
sudo cp galera2.cnf /etc/mysql/conf.d/galera.cnf

