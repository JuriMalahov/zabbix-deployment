#!/bin/bash

echo "Настройка сети для первого сервера"

echo "Настройка /etc/hosts"
sudo cp hosts /etc/hosts

echo "Настройка имени узла"
sudo hostnamectl set-hostname mon-server

echo "Настройка /etc/network/interfaces"
sudo cp interfaces /etc/network/interfaces

echo "Перезапуск сервиса networking"
sudo systemctl restart networking

echo "Включение IP forwarding в /etc/sysctl.conf"
sudo sed -i 's/^#\?net.ipv4.ip_forward.*/net.ipv4.ip_forward=1/' /etc/sysctl.conf

echo "Применение настроек sysctl"
sudo sysctl -p

echo "Настройка маскарадинга"
sudo apt-get update
sudo apt-get install iptables -y
sudo iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -o enp0s3 -j MASQUERADE

echo "Установка iptables-persistent для сохранения правил iptables"
sudo sudo apt-get install iptables-persistent -y

echo "Настройка SSH"
sudo apt-get install openssh-server -y
sudo sed -i 's/^#\?Port.*/Port 22/' /etc/ssh/sshd_config
sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config

echo "Перезапуск sshd"
sudo systemctl restart sshd

echo "Копирование ключей и списка хостов"
sudo mkdir -p ~/.ssh
sudo cp id_rsa ~/.ssh/
sudo cp id_rsa.pub ~/.ssh/

/bin/bash