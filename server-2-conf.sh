#!/bin/bash

echo "Настройка сети для первого сервера"

echo "Настройка имени узла"
hostnamectl set-hostname mon-server-2; /bin/bash

echo "Настройка /etc/hosts"
sudo cat > /etc/hosts <<EOF
127.0.0.1       localhost
127.0.1.1       debian

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
192.168.1.1     mon-server
192.168.1.2     mon-host-1
192.168.1.3     mon-host-2
192.168.1.4     vesr
192.168.1.5     mon-server-2
192.168.1.6     mon-proxy
EOF

echo "Настройка /etc/network/interfaces"
sudo cat > /etc/network/interfaces <<EOF
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

auto enp0s8
iface enp0s8 inet static
address 192.168.1.5/24
EOF

echo "Перезапуск сервиса networking"
sudo systemctl restart networking

echo "Настройка SSH"
sudo apt-get update
sudo apt-get install openssh-server -y
sudo sed -i 's/^#\?Port.*/Port 22/' /etc/sysctl.conf
sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' /etc/sysctl.conf
sudo sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication no/' /etc/sysctl.conf

echo "Перезапуск sshd"
sudo systemctl restart sshd
sudo systemctl enable sshd

echo "Копирование ключа"
sudo mkdir ~/.ssh
sudo cp authorized_keys ~/.ssh/
