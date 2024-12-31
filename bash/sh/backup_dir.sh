#!/bin/bash

# Set variables

external_drive="path/to/my/external/backup/drive/disk/"
log_file="$external_drive/Backups/backup_log.txt"
gpg_path="/usr/bin/gpg/path/"
gpg_recipient="dibattistechasen@gmail.com"
sevenzip_path="/usr/bin/7z/path/"
sevenzip_password="U7.xIr_otsH-3vrX"


# Create the backup folder if it doesn't exist.

mkdir -p "$external_drive/Backups"

# Create the log file 

echo "Backup started at $(date)" > "$log_file"


# Weekly full system backup

if [[ $(date +%u) -eq 7 ]]; then
    rsync -avz/"$external_drive/Backups/Full_Backup_$(date + %m/%d/%Y)" >> "$log_file 2>&1
    if [[ $? -ne 0 ]]; then
      echo "Full system backup failed." >> "$log_file
    fi
fi


# Daily incremental backup