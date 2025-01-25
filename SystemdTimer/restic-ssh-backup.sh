#!/bin/bash

# Set environment variables for restic
export RESTIC_REPOSITORY="sftp:vagrant@192.168.33.20:/home/vagrant/Backup"

# Create the restic.key file if it doesn't exist
if [ ! -f /vagrant/WorkingSystemd_V1/restic.key ]; then
  echo "Creating restic.key file..."
  touch /vagrant/WorkingSystemd_V1/restic.key
  chmod 600 /vagrant/WorkingSystemd_V1/restic.key
fi

# Set the password for the Restic repository
export RESTIC_PASSWORD=$(cat /vagrant/WorkingSystemd_V1/restic.key)

# Perform the backup
restic backup /vagrant

# Cleanup old snapshots (keep last 7 daily, 4 weekly, and 6 monthly backups)
restic forget --keep-daily 7 --keep-weekly 4 --keep-monthly 6 --prune

# Remove the local copy of the key file
rm /vagrant/WorkingSystemd_V1/restic.key