#!/bin/bash

# Variables
REMOTE_USER="your_remote_username"
REMOTE_HOST="your_remote_host"  # Use 'localhost' for testing
REMOTE_DIR="/path/to/remote/backup/directory"
LOG_FILE="$HOME/log/homebackup.log"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="home_backup_$TIMESTAMP.tar.gz"

# Create a log directory if it doesn't exist
mkdir -p "$(dirname "$LOG_FILE")"

# Create a compressed archive of the home directory
tar -czf "/tmp/$BACKUP_FILE" -C "$HOME" .

# Copy the backup to the remote machine
scp "/tmp/$BACKUP_FILE" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR" >> "$LOG_FILE" 2>&1

# Check if the scp command was successful
if [ $? -eq 0 ]; then
    echo "[$TIMESTAMP] Backup successful: $BACKUP_FILE" >> "$LOG_FILE"
else
    echo "[$TIMESTAMP] Backup failed: $BACKUP_FILE" >> "$LOG_FILE"
fi

# Clean up the temporary backup file
rm "/tmp/$BACKUP_FILE"