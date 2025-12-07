#!/bin/bash

echo "Установка Zabbix Agent для хоста 1"

sudo wget https://repo.zabbix.com/zabbix/7.4/release/debian/pool/main/z/zabbix-release/zabbix-release_latest_7.4+debian12_all.deb
sudo dpkg -i zabbix-release_latest_7.4+debian12_all.deb
sudo apt-get update
sudo apt-get install -y zabbix-agent

cd ~/zabbix-deployment/
sudo cp zabbix_agentd1.conf /etc/zabbix/zabbix_agentd.conf

echo "Перезапуск Zabbix agent"

sudo systemctl restart zabbix-agent
sudo systemctl enable zabbix-agent

echo "Установка и настройка Syslog-ng для хоста 1"

sudo apt-get install syslog-ng -y
sudo cp syslog-ng1.conf /etc/syslog-ng/syslog-ng.conf
sudo mkdir -p /etc/syslog-ng/certs
sudo cp ca.crt /etc/syslog-ng/certs
sudo cp mon-host-1.crt /etc/syslog-ng/certs
sudo cp mon-host-1.key /etc/syslog-ng/certs
sudo chown root:root /etc/syslog-ng/certs/ca.crt
sudo chown root:root /etc/syslog-ng/certs/mon-host-1.crt
sudo chown root:root /etc/syslog-ng/certs/mon-host-1.key
sudo ln -s /etc/syslog-ng/certs/ca.crt /etc/syslog-ng/certs/4e83bfff.0

sudo systemctl restart syslog-ng
sudo systemctl enable syslog-ng