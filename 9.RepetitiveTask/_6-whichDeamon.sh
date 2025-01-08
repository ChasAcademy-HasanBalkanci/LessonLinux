#!/bin/bash

# Function to check if a process is running
check_process() {
    if pgrep -x "$1" > /dev/null; then
        echo "$1 is running."
    else
        echo "$1 is not running."
    fi
}

# List of common daemons to check
declare -A daemons
daemons=(
    ["httpd"]="Web server"
    ["init"]="Init daemon"
    ["sshd"]="SSH server"
    ["ntpd"]="NTP daemon"
    ["named"]="Name daemon (DNS)"
    ["acpid"]="Power management daemon"
)

echo "Select a server to check:"
select choice in "${!daemons[@]}" "Other"; do
    case $choice in
        "httpd")
            echo "Checking ${daemons[$choice]}: $choice"
            check_process "httpd"
            ;;
        "init")
            echo "Checking ${daemons[$choice]}: $choice"
            check_process "init"
            ;;
        "sshd")
            echo "Checking ${daemons[$choice]}: $choice"
            check_process "sshd"
            ;;
        "ntpd")
            echo "Checking ${daemons[$choice]}: $choice"
            ntpq -p
            ;;
        "named")
            echo "Checking ${daemons[$choice]}: $choice"
            check_process "named"
            ;;
        "acpid")
            echo "Checking ${daemons[$choice]}: $choice"
            check_process "acpid"
            ;;
        "Other")
            read -p "Enter the name of the process to check: " process_name
            check_process "$process_name"
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
done