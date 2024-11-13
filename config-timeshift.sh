#!/bin/bash

# Définissez le point de montage cible
MOUNT_POINT="/"

# Récupérer l'UUID du périphérique monté sur le point de montage
DEVICE_UUID=$(blkid -s UUID -o value "$(findmnt -no SOURCE "$MOUNT_POINT")")

# Vérifier que l'UUID a été trouvé
if [ -z "$DEVICE_UUID" ]; then
    echo "Erreur : Impossible de récupérer l'UUID pour le point de montage $MOUNT_POINT."
    exit 1
fi

# Générer le fichier de configuration avec l'UUID récupéré
cat <<EOF > /etc/timeshift.json
{
    "backup_device_uuid": "$DEVICE_UUID",
    "parent_device_uuid" : "",
    "do_first_run" : "false",
    "btrfs_mode" : "false",
    "include_btrfs_home_for_backup" : "false",
    "include_btrfs_home_for_restore" : "false",
    "stop_cron_emails" : "true",
    "schedule_monthly" : "true",
    "schedule_weekly" : "false",
    "schedule_daily" : "true",
    "schedule_hourly" : "false",
    "schedule_boot" : "false",
    "count_monthly" : "2",
    "count_weekly" : "3",
    "count_daily" : "3",
    "count_hourly" : "6",
    "count_boot" : "5",
    "date_format" : "%Y-%m-%d %H:%M:%S",
    "exclude" : [
        "/home/**",
        "/root/**"
    ],
    "exclude-apps" : []
}
EOF

# Créer un snapshot
sudo timeshift --create --comments "Backup automatique initial"

echo "Snapshot créé avec succès pour le disque $DEVICE_UUID"