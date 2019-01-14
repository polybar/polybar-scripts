#!/bin/sh
state=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "state:")
percentage=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "percentage:" | cut -d " " -f15 | sed 's/%//')
if [[ "$state" == *"discharging"* ]]; then
  if [ "$percentage" -lt 10 ]; then
    notify-send 'Critical battery level!' 'Critical battery level!' --icon=dialog-information -u critical
  fi
fi
