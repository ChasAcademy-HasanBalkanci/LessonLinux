#!/bin/bash

# Variables
BACKUP_DIR="$HOME"
REMOTE_USER="your_remote_username"
REMOTE_HOST="your_remote_host"  # Use 'localhost' for testing
REMOTE_PATH="/path/to/backup/location"
LOG_FILE="$HOME/log/homebackup.log"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="home_backup_$TIMESTAMP.tar.gz"

# Create log directory if it doesn't exist
mkdir -p "$(dirname "$LOG_FILE")"

# Create a compressed archive of the home directory
echo "[$(date)] Starting backup of $BACKUP_DIR" >> "$LOG_FILE"
tar -czf "/tmp/$BACKUP_FILE" -C "$BACKUP_DIR" .

# Transfer the backup file to the remote machine
echo "[$(date)] Transferring backup to $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH" >> "$LOG_FILE"
scp "/tmp/$BACKUP_FILE" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH"

# Check if the transfer was successful
if [ $? -eq 0 ]; then
    echo "[$(date)] Backup and transfer successful" >> "$LOG_FILE"
    # Optionally, remove the local backup file after successful transfer
    rm "/tmp/$BACKUP_FILE"
else
    echo "[$(date)] Backup or transfer failed" >> "$LOG_FILE"
fi