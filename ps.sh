#!/bin/bash

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
