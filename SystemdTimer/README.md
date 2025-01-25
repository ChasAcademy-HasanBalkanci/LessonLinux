# Automated Restic Backup System for Vagrant VMs

This project sets up an automated backup system using Restic between two Vagrant VMs. It uses systemd timers to schedule regular backups and SSH for secure communication between the VMs.

## Structure

- `Vagrantfile`: Defines the two VMs (source and target)
- `/etc/systemd/system/restic-ssh-backup.service`: Systemd service file for the backup job
- `/etc/systemd/system/restic-ssh-backup.timer`: Systemd timer file to schedule the backup job
- `/usr/local/bin/restic-ssh-backup.sh`: The main backup script
- `/home/vagrant/restic.key`: (On target VM) Contains the password for the Restic repository

## Setup Instructions

### 1. Vagrant Setup

Ensure you have Vagrant installed on your host machine. The `Vagrantfile` should define two VMs:

- Source VM (192.168.33.10): Where the data to be backed up resides
- Target VM (192.168.33.20): Where the backups will be stored


### 2. To set up the system:

1. On the source VM (192.168.33.10):
   - Create the service and timer files in `/etc/systemd/system/`
   - Create the backup script in `/usr/local/bin/` and make it executable:
     ```bash
     sudo chmod +x /usr/local/bin/restic-ssh-backup.sh

     ```


2. On the target VM (192.168.33.20):
   - Create the Backup directory: `mkdir -p /home/vagrant/Backup`
   - Create the restic key file: 
     ```bash
     chmod 600 /home/vagrant/restic.key
     ```
   - Initialize the restic repository: 
     ```bash
     export RESTIC_PASSWORD=$(cat /home/vagrant/restic.key)
     restic init -r /home/vagrant/Backup
     ```

3. Ensure SSH key-based authentication is set up between the VMs.

4. On the source VM, enable and start the timer:
   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable restic-ssh-backup.timer
   sudo systemctl start restic-ssh-backup.timer
   ```

5. Test the backup manually:
   ```bash
   sudo -u vagrant /usr/local/bin/restic-ssh-backup.sh
   ```

### 3.To verify the backup:

1. List snapshots:
   ```bash
   ssh vagrant@192.168.33.20 "export RESTIC_PASSWORD=\$(cat /home/vagrant/restic.key); restic -r /home/vagrant/Backup snapshots"
   ```

2. See contents of the latest backup:
   ```bash
   ssh vagrant@192.168.33.20 "export RESTIC_PASSWORD=\$(cat /home/vagrant/restic.key); restic -r /home/vagrant/Backup ls latest"
   ```

