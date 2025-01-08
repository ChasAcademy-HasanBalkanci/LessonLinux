# to set the limit for users we use  /etc/security/limits.conf
```bash
sudo vim /etc/security/limits.conf
sudo -iu trinity
ps | less
# If we want to see the limits for our current session.
ulimit -a 
# limit currently user process
ulimit -u 5000
# add trinity user to pseudo group
sudo gpasswd -a trinity sudo
# or
sudo usermod -aG sudo trinity
# to set different sudo pollicy. 
# Allow members of group sudo execute any command 
# %sudo ALL=(ALL:ALL) ALL
sudo visudo

sudo -u trinity ls /home/trinity 

```
# The output:

#<domain>      <type>  <item>         <value>
#

#*               soft    core            0
#root            hard    core            100000
#*               hard    rss             10000
#@student        hard    nproc           20
#@faculty        soft    nproc           20
#@faculty        hard    nproc           50


Certainly! Let's dive deeper into sudoers and how to manage it effectively:

1. The sudoers file:
   
   **File: /etc/sudoers**

   This is the main configuration file for sudo. It defines who can use sudo and what commands they can run.

2. Editing sudoers:
   Always use the `visudo` command to edit the sudoers file. This command provides syntax checking to prevent errors that could lock you out of the system.

   ```bash
   sudo visudo
   ```

3. Basic sudoers syntax:
   ```
   user    host=(run_as_user:run_as_group)    NOPASSWD: commands
   ```
   - user: The user or group (prefixed with %) this rule applies to
   - host: The host(s) where this rule applies (ALL for any host)
   - run_as_user: The user(s) the command can be run as
   - run_as_group: The group(s) the command can be run as
   - NOPASSWD: Optional, allows running commands without a password
   - commands: The command(s) that can be run with sudo

4. Common sudoers configurations:

   a. Allow a user to run any command:
   ```
   username ALL=(ALL:ALL) ALL
   ```

   b. Allow a user to run any command without a password:
   ```
   username ALL=(ALL:ALL) NOPASSWD: ALL
   ```

   c. Allow a group to run any command:
   ```
   %groupname ALL=(ALL:ALL) ALL
   ```

   d. Allow a user to run specific commands:
   ```
   username ALL=(ALL:ALL) /bin/ls, /usr/bin/apt
   ```

5. Sudoers.d directory:
   Instead of editing the main sudoers file, you can create separate files in the `/etc/sudoers.d/` directory. This is often cleaner and safer.

   ```bash
   sudo visudo -f /etc/sudoers.d/myconfig
   ```

6. Aliases in sudoers:
   You can define aliases for users, hosts, and commands to simplify complex configurations.

   ```
   User_Alias ADMINS = john, jane, jim
   Cmnd_Alias SYSTEMS = /sbin/reboot, /sbin/halt
   ADMINS ALL = SYSTEMS
   ```

7. Debugging sudo:
   If you're having issues with sudo, you can use the `-l` option to list a user's privileges:

   ```bash
   sudo -l -U username
   ```

8. Security considerations:
   - Be very careful with NOPASSWD options, as they can pose security risks.
   - Avoid giving users more privileges than necessary.
   - Regularly audit your sudoers file to ensure it's up to date and secure.

9. Sudo logs:
   Sudo logs its activities, which can be useful for auditing. On many systems, sudo logs to `/var/log/auth.log`.

Remember, managing sudo permissions is a critical aspect of system security. Always be cautious and thorough when modifying sudoers configurations.

# Modify the sudoers file in such a way to allow the user called trinity to run any sudo command without needing to provide her password.
```bash
sudo visudo /etc/sudoers
trinity    ALL=(ALL)   NOPASSWD: ALL
```

# Modify the sudoers file again. Remove your previous entry for the user called trinity if it still exists.
# Now add a new entry that allows trinity to only run the /usr/bin/mount command with sudo.
```bash
sudo visudo /etc/sudoers
trinity ALL=(ALL) /usr/bin/mount
```

# Make changes in security limits file for user stephen so that he can create maximum filesize upto 4 MiB. This should be a hard limit.
```bash
sudo vi /etc/security/limits.conf
# Add the below line at the end of the file:
stephen hard fsize 4096 
```
# Set a soft limit of 20 processes for everyone in the salesteam group.
```bash
sudo vi /etc/security/limits.conf
# add following 
@salesteam     soft    nproc     20
```
# Define a policy for all the users in the salesteam group to run any sudo command.
```bash
sudo visudo /etc/sudoers
%salesteam     ALL=(ALL)     ALL
```

# Define a policy so that user trinity can run sudo commands as the user sam.
```bash
sudo visudo /etc/sudoers
trinity   ALL=(sam)   ALL
```
# We applied a hard limit of 10 processes for all the users under developers group, but somehow the limit isn't working. Look into the issue and fix the same.

```bash
sudo visudo /etc/sudoers
@developers     hard    nproc   10
```
# Modify the sudoers file again. Remove your previous entry for the user called trinity if it still exists. Now add a new entry that allows trinity to run all commands with sudo, but only after entering the password.

```bash
sudo visudo /etc/sudoers
trinity ALL=(ALL) ALL