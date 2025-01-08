#!/bin/bash
# Exercise 3 
# 1. Variables in local not global
VAR1="thirteen"
VAR2="13"
VAR3="Happy Birthday"

# 2. Display the values of all three variables
echo "VAR1: $VAR1"
echo "VAR2: $VAR2"
echo "VAR3: $VAR3"

# 3. to make them global
export VAR1
export VAR2
export VAR3

echo "Variables are now exported and global"

#4. Remove VAR3
unset VAR3

echo "VAR3 has been removed"

# Verify that VAR3 is no longer set
echo "VAR1: $VAR1"
echo "VAR2: $VAR2"
echo "VAR3: $VAR3"  # This should print an empty line for VAR3

# 6. Edit /etc/profile to add a greeting for all users
echo "Adding greeting to /etc/profile"
sudo sh -c 'echo "echo \"Welcome to the system, \$USER!\"" >> /etc/profile'

# 7. Set special prompt for root account
echo "Setting special prompt for root account"
sudo sh -c 'echo "PS1=\"\e[1;31m\Danger!! root is doing stuff in \w \e[0m\"" >> /root/.bashrc'
echo "Root prompt has been set"

# 8. Set personalized prompt for new users
echo "Setting personalized prompt for new users"
sudo sh -c 'echo "PS1=\"\[\e[1;34m\]\u@\h:\[\e[1;32m\]\w\[\e[0m\]\$ \"" >> /etc/skel/.bashrc'
echo "New user prompt has been set"

#Create a new user for testing
echo "Creating a new user for testing"
sudo adduser testuser
echo "New user 'testuser' created"

echo "Script completed. Please log in as 'testuser' to test the new prompt."

