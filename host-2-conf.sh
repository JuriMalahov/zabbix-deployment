#!/bin/bash

echo "Настройка сети для первого сервера"

echo "Настройка имени узла"
sudo hostnamectl set-hostname mon-host-2

echo "Настройка /etc/hosts"
sudo cp hosts /etc/hosts

echo "Настройка /etc/network/interfaces"
sudo ifdown enp0s3
sudo cp interfaces-h2 /etc/network/interfaces

echo "Перезапуск сервиса networking"
sudo systemctl restart networking

echo "Настройка SSH"
sudo apt-get update
sudo apt-get install openssh-server -y
sudo sed -i 's/^#\?Port.*/Port 22/' /etc/ssh/sshd_config
sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config

echo "Перезапуск sshd"
sudo systemctl restart sshd

echo "Копирование ключа"
sudo mkdir -p ~/.ssh
sudo cp authorized_keys ~/.ssh/

/bin/bash