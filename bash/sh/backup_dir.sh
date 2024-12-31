#!/bin/bash

# Set variables
external_drive="path/to/my/external/backup/drive/disk/"
log_file="$external_drive/Backups/backup_log.txt"
gpg_path="/usr/bin/gpg" # Replace with the actual path
gpg_recipient="dibattistechasen@gmail.com"
sevenzip_path="/usr/bin/7z" # Replace with the actual path
# (Handle sevenzip_password securely - see suggestions above) 

# Create the backup folder if it doesn't exist
mkdir -p "$external_drive/Backups" || { echo "Error creating backup directory" >> "$log_file"; exit 1; } 

# Append to the log file
echo "Backup started at $(date)" >> "$log_file"

# Weekly full system backup
if [[ $(date +%u) -eq 7 ]]; then
  # Replace /home/your_username with the source directory you want to back up
  rsync -avz /home/your_username/ "$external_drive/Backups/Full_Backup_$(date +%m-%d-%Y)" >> "$log_file" 2>&1 
  if [[ $? -ne 0 ]]; then
    echo "Full system backup failed." >> "$log_file"
  fi
else
  # Daily incremental backup (using --link-dest)
  latest_full_backup=$(ls -td "$external_drive/Backups/Full_Backup_"* | head -n1)
  rsync -avz --link-dest="$latest_full_backup" /home/your_username/ "$external_drive/Backups/Incremental_Backup_$(date +%m-%d-%Y)" >> "$log_file" 2>&1
  if [[ $? -ne 0 ]]; then
    echo "Incremental backup failed." >> "$log_file"
  fi
fi

# ... (Add encryption and compression logic if needed) ...
