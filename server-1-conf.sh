#!/bin/bash

echo "Настройка сети для первого сервера"

echo "Настройка имени узла"
hostnamectl set-hostname mon-server

echo "Настройка /etc/hosts"
sudo echo "127.0.0.1       localhost
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
192.168.1.6     mon-proxy" > /etc/hosts
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

#echo "Настройка /etc/resolv.conf"
#sudo cat > /etc/hosts <<EOF
#nameserver 8.8.8.8
#EOF

echo "Настройка /etc/network/interfaces"
sudo echo "# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

auto enp0s3
iface enp0s3 inet dhcp
auto enp0s8
iface enp0s8 inet static
address 192.168.1.1/24" > /etc/network/interfaces
sudo cat > /etc/network/interfaces <<EOF
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

auto enp0s3
iface enp0s3 inet dhcp
auto enp0s8
iface enp0s8 inet static
address 192.168.1.1/24
EOF

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

echo "Сохранение правил iptables в /home/user/rules"
sudo iptables-save > ~/rules

echo "Добавление команды восстановления правил iptables при перезапуске в crontab"
(crontab -l 2>/dev/null; echo "@reboot /sbin/iptables-restore < /home/user/rules") | crontab -

echo "Настройка SSH"
sudo apt-get install openssh-server -y
sudo sed -i 's/^#\?Port.*/Port 22/' /etc/sysctl.conf
sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' /etc/sysctl.conf
sudo sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication no/' /etc/sysctl.conf

echo "Перезапуск sshd"
sudo systemctl restart sshd
sudo systemctl enable sshd

echo "Копирование ключей и списка хостов"
sudo mkdir ~/.ssh
sudo cp id_rsa ~/.ssh/
sudo cp id_rsa.pub ~/.ssh/
sudo cp known_hosts ~/.ssh/
