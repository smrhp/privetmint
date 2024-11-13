#!/bin/bash
#
# installation d'anydek
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | gpg --dearmor -o /usr/share/keyrings/anydesk-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/anydesk-archive-keyring.gpg] https://deb.anydesk.com/deb stable main" > /etc/apt/sources.list.d/anydesk.list

apt-get update && apt-get --force-yes dist-upgrade
apt install -y anydesk vim remmina remmina-* conky-all openssh-server numlockx
