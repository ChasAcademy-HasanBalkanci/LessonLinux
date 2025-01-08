#!/bin/bash

# Get the current month and year
month=$(date +%m)
year=$(date +%Y)

# Determine the number of days in the current month
case $month in
  "01")
    echo "January has 31 days."
    ;;
  "02")
    # Check if the current year is a leap year
    if (( (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0) )); then
      echo "February has 29 days (leap year)."
    else
      echo "February has 28 days."
    fi
    ;;
  "03")
    echo "March has 31 days."
    ;;
  "04")
    echo "April has 30 days."
    ;;
  "05")
    echo "May has 31 days."
    ;;
  "06")
    echo "June has 30 days."
    ;;
  "07")
    echo "July has 31 days."
    ;;
  "08")
    echo "August has 31 days."
    ;;
  "09")
    echo "September has 30 days."
    ;;
  "10")
    echo "October has 31 days."
    ;;
  "11")
    echo "November has 30 days."
    ;;
  "12")
    echo "December has 31 days."
    ;;
  *)
    echo "Invalid month."
    ;;
esac