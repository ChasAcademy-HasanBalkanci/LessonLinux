#!/bin/bash

# Set environment variables for restic
export RESTIC_REPOSITORY="sftp:vagrant@192.168.33.20:/home/vagrant/Backup"

# Copy the key file from the remote server and set the password
scp vagrant@192.168.33.20:/home/vagrant/restic.key /home/vagrant/restic.key
chmod 600 /home/vagrant/restic.key
export RESTIC_PASSWORD=$(cat /home/vagrant/restic.key)

# Perform the backup
restic backup /vagrant

# Cleanup old snapshots (keep last 7 daily, 4 weekly, and 6 monthly backups)
restic forget --keep-daily 7 --keep-weekly 4 --keep-monthly 6 --prune

# Remove the local copy of the key file
rm /home/vagrant/restic.key