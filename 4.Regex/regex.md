#!/bin/bash

# 1. Display users with Bash as default shell
echo "1. Users with Bash as default shell:"
grep "/bin/bash" /etc/passwd | cut -d: -f1

# 2. Display lines starting with "daemon" from /etc/group
echo -e "\n2. Lines starting with 'daemon' in /etc/group:"
grep "^daemon" /etc/group

# 3. Display lines not containing "daemon" from /etc/group
echo -e "\n3. Lines not containing 'daemon' in /etc/group:"
grep -v "daemon" /etc/group

# 4. Display localhost information from /etc/hosts with line numbers and count
echo -e "\n4. Localhost information from /etc/hosts:"
grep -n "localhost" /etc/hosts 
# -n: This option tells grep to prefix each line of output with the line number in the input file.

echo "Occurrences of 'localhost':"
grep -c "localhost" /etc/hosts

# 5. Display /usr/share/doc subdirectories about shells and count README files
echo -e "\n5. /usr/share/doc subdirectories about shells:"
ls -dR /usr/share/doc/*sh*
echo "Number of README files (excluding README.*):"
find /usr/share/doc/*sh* -name "README" | wc -l

# 6. List files in home directory changed less than 10 hours ago
echo -e "\n6. Files in home directory changed less than 10 hours ago:"
find ~ -type f -mtime -0.4 | grep -v "/$"

# 

# 8. The script is generating comprehensible output for each exercise

# 9. Alternative for wc -l using grep
echo -e "\n9. Number of lines in /etc/passwd using grep:"
grep -c ".*" /etc/passwd

# 10. List local disk devices from /etc/fstab
echo -e "\n10. Local disk devices from /etc/fstab:"
grep -v "^#" /etc/fstab | awk '$3 == "ext4" {print $1}'

# 11. Check if a user exists in /etc/passwd
echo -e "\n11. Check if user 'root' exists:"
if grep -q "^root:" /etc/passwd; then
    echo "User 'root' exists"
else
    echo "User 'root' does not exist"
fi

# 12. Display configuration files in /etc with numbers in their names
echo -e "\n12. Configuration files in /etc with numbers in their names:"
ls /etc | grep '[0-9]'