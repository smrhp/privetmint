#!/bin/bash

read -p "Nom de l'utilisateur à créer :" username
if [ -z "$username" ]; then
  echo "Vous devez saisir un nom d'utilisateur"
  exit -1
fi
sudo useradd -m $username
# Vérification de la création de l'utilisateur
if [ $? -eq 0 ]; then
  # Utiliser le nom d'utilisateur comme mot de passe
  echo "$username:$username" | sudo chpasswd
  echo "L'utilisateur $username a été créé avec le mot de passe par défaut."
  sudo cp src/templates/conkyrc.tpl /home/$username/.conkyrc
  sudo chown -R $username: /home/$username
else
  echo "Erreur lors de la création de l'utilisateur."
  exit -1
fi

# installation fichiers privetcloud
sudo mkdir /usr/local/share/privetcloud
sudo chown -R privetcloud: /usr/local/share/privetcloud
cp -r src/usr/local/share/privetcloud/* /usr/local/share/privetcloud/

# installation anydesk
wget -O /tmp/anydesk.deb https://download.anydesk.com/linux/anydesk_6.4.0-1_amd64.deb
apt -f -y install /tmp/anydesk.deb

# configuration personnalisée.
sudo tee -a /etc/lightdm/slick-greeter.conf <<EOL
[Greeter]
logo=/usr/local/share/privetcloud/logo.png
activate-numlock=true
EOL

apt-get update
apt install -y vim remmina remmina-* conky-all openssh-server numlockx
apt-get -y dist-upgrade

bash config-droits.sh
bash config-timeshift.sh