#!/bin/bash

# installation fichiers privetcloud
mkdir /usr/local/share/privetcloud
cp -r src/usr/local/share/privetcloud /usr/local/share/privetcloud
chown -R privetcloud: /usr/local/share/privetcloud

# installation anydesk
wget -O /tmp/anydesk.deb https://download.anydesk.com/linux/anydesk_6.4.0-1_amd64.deb
apt -f install /tmp/anydesk.deb

apt-get update && apt-get --force-yes dist-upgrade
apt install -y vim remmina remmina-* conky-all openssh-server numlockx
