#!/bin/bash

# Variables
BACKUP_DIR="$HOME"
BACKUP_FILE="/tmp/home_backup.tar"
COMPRESSED_FILE="/tmp/home_backup.tar.gz"
REMOTE_USER="your_remote_username"
REMOTE_HOST="your_remote_host"  # Use 'localhost' for testing
REMOTE_PATH="/path/to/backup/location"
LOG_FILE="$HOME/log/homebackup.log"

# Create log directory if it doesn't exist
mkdir -p "$(dirname "$LOG_FILE")"

# Check for existing compressed archive and remove it
if [ -f "$COMPRESSED_FILE" ]; then
    echo "[$(date)] Removing existing compressed archive" >> "$LOG_FILE"
    rm "$COMPRESSED_FILE"
fi

# Check available disk space
REQUIRED_SPACE_MB=1000  
AVAILABLE_SPACE_MB=$(df --output=avail /tmp | tail -1)

if [ "$AVAILABLE_SPACE_MB" -lt "$REQUIRED_SPACE_MB" ]; then
    echo "[$(date)] Not enough disk space available for backup" >> "$LOG_FILE"
    exit 1
fi

# Create a tar archive of the home directory
echo "[$(date)] Creating tar archive of $BACKUP_DIR" >> "$LOG_FILE"
tar cf "$BACKUP_FILE" -C "$BACKUP_DIR" .

# Compress the tar archive
echo "[$(date)] Compressing the tar archive" >> "$LOG_FILE"
gzip "$BACKUP_FILE"

# Transfer the compressed file to the remote machine
echo "[$(date)] Transferring backup to $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH" >> "$LOG_FILE"
scp "$COMPRESSED_FILE" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH"

# Check if the transfer was successful
if [ $? -eq 0 ]; then
    echo "[$(date)] Backup and transfer successful" >> "$LOG_FILE"
    # Clean up the compressed archive
    rm "$COMPRESSED_FILE"
else
    echo "[$(date)] Backup or transfer failed" >> "$LOG_FILE"
fi