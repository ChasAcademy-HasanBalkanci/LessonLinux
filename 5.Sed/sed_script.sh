#!/bin/bash

# Check if a file is provided as an argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

# Check if the file exists
if [ ! -f "$1" ]; then
    echo "Error: File '$1' not found."
    exit 1
fi

# Use sed to find lines with trailing whitespace
result=$(sed -n -f /tmp/trailing_whitespace.sed "$1")

# Check if any lines with trailing whitespace were found
if [ -z "$result" ]; then
    echo "No lines with trailing whitespace found in '$1'."
else
    echo "Lines with trailing whitespace in '$1':"
    echo "$result" | while IFS= read -r line; do
        line_number=$(grep -n "^$line$" "$1" | cut -d: -f1)
        echo "Line $line_number: $line"
    done
    echo "Tip: Use 'sed -i 's/[[:space:]]*$//' $1' to remove trailing whitespace."
fi
