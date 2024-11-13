#!/bin/bash

read -p "Nom de l'utilisateur à créer :" username
if [ -z "$username" ]; then
  echo "Vous devez saisir un nom d'utilisateur"
  return -1
]
sudo useradd -m $username
# Vérification de la création de l'utilisateur
if [ $? -eq 0 ]; then
  # Utiliser le nom d'utilisateur comme mot de passe
  echo "$username:$username" | sudo chpasswd
  echo "L'utilisateur $username a été créé avec le mot de passe par défaut."
  sudo cp /src/templates/conky.tpl /home/$username/.conkyrc
  sudo chown -R $username: /home/$username
else
  echo "Erreur lors de la création de l'utilisateur."
  return -1
fi

# installation fichiers privetcloud
sudo mkdir /usr/local/share/privetcloud
cp -r src/usr/local/share/privetcloud /usr/local/share/privetcloud
chown -R privetcloud: /usr/local/share/privetcloud

# installation anydesk
wget -O /tmp/anydesk.deb https://download.anydesk.com/linux/anydesk_6.4.0-1_amd64.deb
apt -f install /tmp/anydesk.deb

apt-get update && apt-get --force-yes dist-upgrade
apt install -y vim remmina remmina-* conky-all openssh-server numlockx
