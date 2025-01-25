#!/bin/bash

set -e

# Configuration. It should be arranged to align with the system that the script runs.
TARGET_VM_IP="192.168.33.20"
BACKUP_SOURCE="/vagrant/WorkingSystemd"
BACKUP_REPO="/vagrant/backups"
ENV_FILE="/etc/restic/restic.env"

# Function to run commands on the target VM
run_on_target() {
    ssh -o StrictHostKeyChecking=no vagrant@$TARGET_VM_IP "$@"
}

# Install restic on both VMs
install_restic() {
    if ! command -v restic &> /dev/null; then
        echo "Installing restic..."
        if command -v apt &> /dev/null; then
            sudo apt update
            sudo apt install -y restic
        elif command -v yum &> /dev/null; then
            # Check if it's CentOS 8
            if grep -q "CentOS Linux 8" /etc/os-release; then
                echo "CentOS 8 detected. Switching to CentOS Stream 8..."
                sudo sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
                sudo sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
                sudo dnf swap centos-linux-repos centos-stream-repos -y
                sudo dnf distro-sync -y
            fi
            sudo yum install -y epel-release
            sudo yum install -y restic
        else
            echo "Error: Unable to install restic. Neither apt nor yum found."
            exit 1
        fi
    fi
}
# Install restic on local VM
install_restic

# Install restic on target VM
run_on_target "$(declare -f install_restic); install_restic"

# Setup SSH key-based authentication
if [ ! -f ~/.ssh/id_rsa ]; then
    ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
fi
ssh-copy-id -i ~/.ssh/id_rsa.pub vagrant@$TARGET_VM_IP

# Create backup repository on target VM
run_on_target "mkdir -p $BACKUP_REPO"
run_on_target "restic init --repo $BACKUP_REPO"

# Create environment file for restic
sudo mkdir -p /etc/restic
sudo bash -c "cat << EOF > $ENV_FILE
RESTIC_REPOSITORY=sftp:vagrant@$TARGET_VM_IP:$BACKUP_REPO
RESTIC_PASSWORD=vagrant 
EOF"
sudo chmod 600 $ENV_FILE

# Create the backup script
cat << EOF > /tmp/restic_backup.sh
#!/bin/bash
source $ENV_FILE
export PATH=\$PATH:/usr/bin:/usr/local/bin
restic backup $BACKUP_SOURCE
restic forget --keep-daily 7 --keep-weekly 4 --keep-monthly 6 --prune
EOF

sudo mv /tmp/restic_backup.sh /usr/local/bin/restic_backup.sh
sudo chmod +x /usr/local/bin/restic_backup.sh

# Create systemd service file
cat << EOF | sudo tee /etc/systemd/system/restic-backup.service
[Unit]
Description=Restic backup service
After=network.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/restic_backup.sh
User=root
EnvironmentFile=$ENV_FILE

[Install]
WantedBy=multi-user.target
EOF

# Create systemd timer file
cat << EOF | sudo tee /etc/systemd/system/restic-backup.timer
[Unit]
Description=Run restic backup 5 minutes after boot

[Timer]
OnBootSec=5min
Unit=restic-backup.service

[Install]
WantedBy=timers.target
EOF

# Reload systemd, enable and start the timer
sudo systemctl daemon-reload
sudo systemctl enable restic-backup.timer
sudo systemctl start restic-backup.timer

echo "Backup system setup complete!"
echo "The first backup will run 5 minutes after the next boot."
echo "You can manually trigger a backup by running: sudo systemctl start restic-backup.service"
echo "IMPORTANT: Edit $ENV_FILE and set a strong RESTIC_PASSWORD before rebooting or running a backup!"