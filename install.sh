#!/bin/bash
# (c) Mihai Chiroiu - CDCI

# upgrade system
sudo apt-get update
sudo apt-get -f -y upgrade
sudo apt-get -f -y autoremove
#sudo do-release-upgrade

# some Ubuntu 18.04 tweaks
systemctl disable ufw
sudo systemctl disable systemd-resolved
sudo systemctl stop systemd-resolved
sudo echo "nameserver 8.8.8.8"> /etc/resolv.conf
sudo echo "127.0.0.1 cdci" >> /etc/hosts


# https://containernet.github.io/#installation
cd ..
sudo apt-get install -f -y ansible git aptitude docker
git clone https://github.com/containernet/containernet.git
cd containernet/ansible
sudo ansible-playbook -i "localhost," -c local install.yml
cd ..
sudo make develop

# make containers for labs
cd cdci/containers
make

cd ..
git clone https://github.com/mihai-chiroiu/cdci.git