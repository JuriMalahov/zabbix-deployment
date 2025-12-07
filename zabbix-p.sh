#!/bin/bash

echo "Установка Zabbix Proxy для proxy сервера"

sudo wget https://repo.zabbix.com/zabbix/7.4/release/debian/pool/main/z/zabbix-release/zabbix-release_latest_7.4+debian12_all.deb
sudo dpkg -i zabbix-release_latest_7.4+debian12_all.deb
sudo apt-get update
sudo apt-get install -y zabbix-proxy-mysql zabbix-sql-scripts

cd ~/zabbix-deployment/
sudo cp zabbix_proxy.conf /etc/zabbix/zabbix_proxy.conf

echo "Установка и настройка MariaDB для прокси"

sudo apt-get install rsync mariadb-server galera-4 -y

sudo mysql -uroot -p1234 -e "create database zabbix_proxy character set utf8mb4 collate utf8mb4_bin;"
sudo mysql -uroot -p1234 -e "create user zabbix@localhost identified by 'password';"
sudo mysql -uroot -p1234 -e "grant all privileges on zabbix_proxy.* to zabbix@localhost;"
sudo mysql -uroot -p1234 -e "set global log_bin_trust_function_creators = 0;"

echo "Восстановление базы данных прокси"

sudo mysql -uroot -p1234 zabbix_proxy < zabbix_proxy_dump.SQL

echo "Перезапуск Zabbix proxy"

sudo systemctl restart zabbix-proxy
sudo systemctl enable zabbix-proxy

