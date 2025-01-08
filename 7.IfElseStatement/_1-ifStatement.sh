#!/bin/bash

# Get the current month and year
month=$(date +%m)
year=$(date +%Y)

# Determine the number of days in the current month
if [ "$month" -eq 1 ]; then
    echo "January has 31 days."
elif [ "$month" -eq 2 ]; then
    # Check if the current year is a leap year
    if (( (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0) )); then
        echo "February has 29 days (leap year)."
    else
        echo "February has 28 days."
    fi
elif [ "$month" -eq 3 ]; then
    echo "March has 31 days."
elif [ "$month" -eq 4 ]; then
    echo "April has 30 days."
elif [ "$month" -eq 5 ]; then
    echo "May has 31 days."
elif [ "$month" -eq 6 ]; then
    echo "June has 30 days."
elif [ "$month" -eq 7 ]; then
    echo "July has 31 days."
elif [ "$month" -eq 8 ]; then
    echo "August has 31 days."
elif [ "$month" -eq 9 ]; then
    echo "September has 30 days."
elif [ "$month" -eq 10 ]; then
    echo "October has 31 days."
elif [ "$month" -eq 11 ]; then
    echo "November has 30 days."
elif [ "$month" -eq 12 ]; then
    echo "December has 31 days."
else
    echo "Invalid month."
fi