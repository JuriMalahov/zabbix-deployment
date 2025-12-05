#!/bin/bash

echo "Настройка сети для первого сервера"

echo "Настройка имени узла"
hostnamectl set-hostname mon-proxy

echo "Настройка /etc/hosts"
sudo cp hosts /etc/hosts

echo "Настройка /etc/network/interfaces"
sudo cp interfaces-p /etc/network/interfaces

echo "Перезапуск сервиса networking"
sudo systemctl restart networking
sudo ifdown enp0s3

echo "Настройка SSH"
sudo apt-get update
sudo apt-get install openssh-server -y
sudo sed -i 's/^#\?Port.*/Port 22/' /etc/ssh/sshd_config
sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config

echo "Перезапуск sshd"
sudo systemctl restart sshd
sudo systemctl enable sshd

echo "Копирование ключа"
sudo mkdir ~/.ssh
sudo cp authorized_keys ~/.ssh/

/bin/bash