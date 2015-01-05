#!/bin/bash


apt-get update
apt-get upgrade 
apt-get install libssl--dev libnl-3-dev iw macchanger libnl-genl-3-dev libnl-3-dev -y


cd ~ && wget http://download.aircrack-ng.org/aircrack-ng-1.2-rc1.tar.gz
tar -zxvf aircrack-ng-1.2-rc1.tar.gz
cd aircrack-ng-1.2-rc1
make
make install

# done 
airodump-ng-oui-update



