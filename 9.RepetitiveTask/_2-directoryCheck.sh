#!/bin/bash

# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Check if the argument is a directory
if [ ! -d "$1" ]; then
    echo "Error: $1 is not a directory."
    exit 1
fi

DIRECTORY="$1"

echo "Analyzing directory: $DIRECTORY"

# Find and print the five biggest files
echo "Five biggest files:"
find "$DIRECTORY" -type f -exec du -h {} + | sort -rh | head -n 5

echo ""

# Find and print the five most recently modified files
echo "Five most recently modified files:"
find "$DIRECTORY" -type f -printf '%T@ %p\n' | sort -k1,1nr | cut -d' ' -f2- | head -n 5