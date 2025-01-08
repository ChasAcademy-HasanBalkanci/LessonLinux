# 🚀 Linux User Management and Permissions Hands-On
## Complete Script
#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# 1. Creates users Alice, Bob, Charlie, David, and Evert.
for user in alice bob charlie david evert; do
    sudo useradd $user
    echo "Created user: $user"
done

# 2. Creates the 'developers' group and adds Alice, Charlie, and Evert to it.
sudo groupadd developers
for dev in alice charlie evert; do
    sudo usermod -aG developers $dev
    echo "Added $dev to developers group"
done

# 3. Create shared directory
# -p: This option allows mkdir to create parent directories if they don't exist. 
# It also prevents errors if the directory already exists.
sudo mkdir -p /opt/developers
sudo chgrp developers /opt/developers

# 2: Sets the SGID (Set Group ID) bit. This means that new files and subdirectories created within this directory will inherit the group ownership of the parent directory.
sudo chmod 2770 /opt/developers
echo "Created shared directory: /opt/developers"

# 4. Set account expiration for Bob and David
for consultant in bob david; do
    sudo usermod -e 2024-12-31 $consultant
    echo "Set account expiration for $consultant to 2024-12-31"
done

# 5. Force Evert to change password on next login
sudo passwd -e evert
echo "Forced Evert to change password on next login"

# Verification steps
echo -e "\nVerification:"
echo "Group memberships:"
for user in alice bob charlie david evert; do
    echo -n "$user: "
    groups $user
done

echo -e "\nDirectory permissions for /opt/developers:"
ls -ld /opt/developers

echo -e "\nAccount expiration for Bob and David:"
for consultant in bob david; do
    echo "$consultant:"
    sudo chage -l $consultant | grep "Account expires"
done

echo -e "\nPassword status for Evert:"
sudo passwd -S evert