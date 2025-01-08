#!/bin/bash

# Get the current month and year.
month=$(date +"%B")
year=$(date +"%Y")

# Determine the number of days in the current month.
case $month in
    "January")
        echo "January has 31 days."
        ;;
    "February")
        # Check if the current year is a leap year
        if (( (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0) )); then
            echo "February has 29 days (leap year)."
        else
            echo "February has 28 days."
        fi
        ;;
    "March")
        echo "March has 31 days."
        ;;
    "April")
        echo "April has 30 days."
        ;;
    "May")
        echo "May has 31 days."
        ;;
    "June")
        echo "June has 30 days."
        ;;
    "July")
        echo "July has 31 days."
        ;;
    "August")
        echo "August has 31 days."
        ;;
    "September")
        echo "September has 30 days."
        ;;
    "October")
        echo "October has 31 days."
        ;;
    "November")
        echo "November has 30 days."
        ;;
    "December")
        echo "December has 31 days."
        ;;
    *)
        echo "Invalid month."
        ;;
esac