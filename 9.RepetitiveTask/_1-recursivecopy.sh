#!/bin/bash

# Define the source and backup directories. It is dynamic aproach.
SOURCE_DIR="/etc"
BACKUP_DIR="/home/user/etc_backup"

# Create the backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR" # -p means parents 

# Copy the files recursively from the source to the backup directory
cp -r "$SOURCE_DIR"/* "$BACKUP_DIR" # -r means recursivly

echo "Backup of /etc completed successfully in $BACKUP_DIR"