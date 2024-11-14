#!/bin/bash
# configure les droits divers et variés

utilisateur=$1

# donne les droits à l'utilisateur sur des pilotes utiles (bluetooth, wifi)
sudo usermod -a -G bluetooth $utilisateur
sudo usermod -a -G netdev $utilisateur