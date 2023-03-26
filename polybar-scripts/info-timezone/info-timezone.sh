#!/bin/sh

# Change format here. see `man date` for format controls.
FORMAT="%I:%M %p"

# Add the timezones of your choice. see `timedatectl list-timezones`.
TIMEZONES=("UTC-0" "Australia/Sydney" "Asia/Kolkata" "America/Chicago")

TIMEZONES_LENGTH=${#TIMEZONES[@]}
current_idx=0

print_date() {
  current_timezone=${TIMEZONES[${current_idx}]}
  TZ=${current_timezone} date +"${FORMAT}" | echo "${current_timezone}: $(cat -)"
}

update_current_timezone() {
  current_idx=$(expr $((current_idx+1)) % $TIMEZONES_LENGTH)
}

click() {
  update_current_timezone
  print_date
}

trap "click" USR1

while true; do
  print_date
  sleep 5 &
  wait
done
