#!/bin/bash

# Check if exactly one argument is supplied
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <year>"
    exit 
fi

# Get the year from the argument
year=$1

# Test if the provided year is a leap year
if (( (year % 400 == 0) || (year % 4 == 0 && year % 100 != 0) )); then
    echo "This is a leap year."
else
    echo "This is not a leap year. Don't forget to charge the extra day!"
fi