#!/bin/bash

# Check if exactly one argument is supplied
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <year>"
    exit 1
fi

# Get the year from the argument
year=$1

# Check if the provided year is a leap year
if (( (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0) )); then
    echo "$year is a leap year. Don't forget to charge the extra day!"
else
    echo "$year is not a leap year."
fi