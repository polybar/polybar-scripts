#!/bin/sh

day=$(timedatectl | grep "Local" | cut -d ":" -f2 | cut -d " " -f3 | cut -d "-" -f3)
month=$(timedatectl | grep "Local" | cut -d ":" -f2 | cut -d " " -f3 | cut -d "-" -f2)
year=$(timedatectl | grep "Local" | cut -d ":" -f2 | cut -d " " -f3 | cut -d "-" -f1)

day=$(echo "obase=16; $day" | bc)
month=$(echo "obase=16; $month" | bc)
year=$(echo "obase=16; $year" | bc)

echo "$day-$month-$year"
