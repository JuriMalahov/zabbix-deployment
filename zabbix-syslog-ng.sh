#!/bin/bash

echo "Развертывание Zabbix Server"

echo "Установка Zabbix Server для server 1"

sudo wget https://repo.zabbix.com/zabbix/7.4/release/debian/pool/main/z/zabbix-release/zabbix-release_latest_7.4+debian12_all.deb
sudo dpkg -i zabbix-release_latest_7.4+debian12_all.deb
sudo apt-get update
sudo apt-get install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent

sudo cp zabbix_server.conf /etc/zabbix/zabbix_server.conf
sudo cp zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf

echo "Установка и настройка MariaDB для server 1"

sudo apt-get install rsync mariadb-server galera-4 -y

sudo mysql -uroot -p1234 -e "create database zabbix character set utf8mb4 collate utf8mb4_bin;"
sudo mysql -uroot -p1234 -e "create user zabbix@localhost identified by 'password';"
sudo mysql -uroot -p1234 -e "grant all privileges on zabbix.* to zabbix@localhost;"
sudo mysql -uroot -p1234 -e "set global log_bin_trust_function_creators = 0;"

echo "Восстановление базы данных сервера"

sudo mysql -uroot -p1234 zabbix < zabbix_dump.SQL

echo "Настройка Galera для server 1"

sudo systemctl stop mariadb
sudo cp galera1.cnf /etc/mysql/conf.d/galera.cnf


echo "Подключение к mon-server-2"

ssh user@mon-server-2 -o StrictHostKeyChecking=accept-new < zabbix-s2.sh

echo "Запуск кластера Galera и Zabbix server 1"

sudo galera_new_cluster
sudo systemctl restart zabbix-server zabbix-agent apache2
sudo systemctl enable zabbix-server zabbix-agent apache2

echo "Запуск MariaDB и Zabbix server 2"

ssh user@mon-server-2 "sudo systemctl restart mariadb"
ssh user@mon-server-2 "sudo systemctl restart zabbix-server zabbix-agent apache2"
ssh user@mon-server-2 "sudo systemctl enable zabbix-server zabbix-agent apache2"


echo "Подключение к mon-proxy"

ssh user@mon-proxy -o StrictHostKeyChecking=accept-new < zabbix-p.sh

echo "Установка и настройка Syslog-ng для server 1"

sudo apt-get install syslog-ng -y
sudo cp syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
sudo mkdir -p /etc/syslog-ng/certs
sudo cp ca.crt /etc/syslog-ng/certs
sudo cp mon-server.crt /etc/syslog-ng/certs
sudo cp mon-server.key /etc/syslog-ng/certs
sudo chown root:root /etc/syslog-ng/certs/ca.crt
sudo chown root:root /etc/syslog-ng/certs/mon-server.crt
sudo chown root:root /etc/syslog-ng/certs/mon-server.key
sudo ln -s /etc/syslog-ng/certs/ca.crt /etc/syslog-ng/certs/4e83bfff.0

sudo mkdir -p /var/log/my-logs

sudo systemctl restart syslog-ng
sudo systemctl enable syslog-ng

echo "Подключение к mon-host-1"

ssh user@mon-host-1 -o StrictHostKeyChecking=accept-new < zabbix-h1.sh

echo "Подключение к mon-host-2"

ssh user@mon-host-2 -o StrictHostKeyChecking=accept-new < zabbix-h2.sh
