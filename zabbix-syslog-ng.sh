#!/bin/bash

echo "Развертывание Zabbix"

echo "Установка Zabbix Server для server 1"

sudo wget https://repo.zabbix.com/zabbix/7.4/release/debian/pool/main/z/zabbix-release/zabbix-release_latest_7.4+debian12_all.deb
sudo dpkg -i zabbix-release_latest_7.4+debian12_all.deb
sudo apt-get update
sudo apt-get install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent

sudo cp zabbix_server.conf /etc/zabbix/zabbix_server.conf
sudo cp zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf

echo "Установка и настройка MariaDB для server 1"

sudo apt-get install mariadb-server -y
#sudo mysql -uroot -p1234

sudo mysql -uroot -p1234 -e "create database zabbix character set utf8mb4 collate utf8mb4_bin;"
sudo mysql -uroot -p1234 -e "create user zabbix@localhost identified by 'password';"
sudo mysql -uroot -p1234 -e "grant all privileges on zabbix.* to zabbix@localhost;"
sudo mysql -uroot -p1234 -e "set global log_bin_trust_function_creators = 0;"
#quit;

echo "Восстановление базы данных сервера"

sudo mysql -uroot -p1234 zabbix < zabbix_dump.SQL

echo "Настройка Galera для server 1"

sudo systemctl stop mariadb
sudo cp galera1.cnf /etc/mysql/conf.d/galera.cnf



ssh user@mon-server-2 -o StrictHostKeyChecking=no < zabbix-s2.sh

echo "Запуск кластера Galera и Zabbix server 1"

sudo systemctl restart mariadb
sudo systemctl restart zabbix-server zabbix-agent apache2
sudo systemctl enable zabbix-server zabbix-agent apache2


