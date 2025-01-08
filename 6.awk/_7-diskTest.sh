#!/bin/bash

# Variables
BACKUP_DIR="/actual/path/to/backup"  # Replace with your actual backup directory
ARCHIVE_NAME="backup.tar"
COMPRESSED_ARCHIVE_NAME="backup.tar.gz"
REMOTE_SERVER="remote.server.com"  # Replace with your actual remote server
REMOTE_DIR="/actual/path/to/remote/backup"  # Replace with your actual remote directory
LOG_FILE="/actual/path/to/logfile.log"  # Replace with your actual log file path

# Check disk space
space=$(df -h | awk '{print $5}' | grep % | grep -v Use | sort -n | tail -1 | cut -d "%" -f1 -)

# Determine message based on disk usage
case $space in
  [1-9]) 
    Message="Disk space is below 10%. All is quiet."
    ;;
  [1-6]*)
    Message="All is quiet."
    ;;
  [7-8]*)
    Message="Start thinking about cleaning out some stuff. There's a partition that is $space % full."
    ;;
  90)
    Message="Warning: A partition is exactly 90% full."
    ;;
  9[1-8])
    Message="Better hurry with that new disk... One partition is $space % full."
    ;;
  99)
    Message="I'm drowning here! There's a partition at $space %!"
    ;;
  *)
    Message="I seem to be running with a nonexistent amount of disk space..."
    ;;
esac

# Log the message
echo $Message >> $LOG_FILE

# Check for existing compressed archive and remove it
if [ -f "$BACKUP_DIR/$COMPRESSED_ARCHIVE_NAME" ]; then
  rm "$BACKUP_DIR/$COMPRESSED_ARCHIVE_NAME"
fi

# Check available disk space before creating backup
required_space=1000 # Example required space in MB
available_space=$(df -m "$BACKUP_DIR" | awk 'NR==2 {print $4}')

if [ "$available_space" -lt "$required_space" ]; then
  echo "Not enough disk space for backup. Exiting." >> $LOG_FILE
  exit 1
fi

# Create a tar archive and compress it
tar cf "$BACKUP_DIR/$ARCHIVE_NAME" /actual/path/to/data  # Replace with your actual data path
gzip "$BACKUP_DIR/$ARCHIVE_NAME"

# Transfer the compressed archive to the remote server
scp "$BACKUP_DIR/$COMPRESSED_ARCHIVE_NAME" "$REMOTE_SERVER:$REMOTE_DIR"

# Clean up the compressed archive
rm "$BACKUP_DIR/$COMPRESSED_ARCHIVE_NAME"

# Send email notification
echo $Message | mail -s "Disk report $(date)" anny