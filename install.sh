#!/bin/bash
# (c) Alex Mircea - Curs Formare POCU

# upgrade system
sudo apt-get update
sudo apt-get -f -y upgrade
sudo apt-get -f -y autoremove
#sudo do-release-upgrade

# some Ubuntu 18.04 tweaks
systemctl disable ufw

# https://containernet.github.io/#installation
cd ..
sudo apt-get install -f -y ansible git aptitude docker
git clone https://github.com/containernet/containernet.git
cd containernet
sudo python setup.py install
cd ansible
sudo ansible-playbook -i "localhost," -c local install.yml
cd ..
sudo make develop

# make containers for labs
cd  pocuLabInfra/containers
sudo make

cd ..
git pull
