#!/bin/bash

#Replace this variable, Ex: "70:26:06:DD:E1:34"
device=""
R="$(hciconfig)"

#if arguments: current state of the bluetooth
if [ "$#" -ne 0 ]; then
  if [[ $R == *"UP"* ]]; then
    echo "%{F#458588}#%{F-}"
  else
    echo "%{F#888}#%{F-}"
  fi
  exit
fi

# no argument: switching state of the bluetooth
if [[ $R == *"UP"* ]]; then
  echo "power off" | bluetoothctl
  echo "%{F#888}#%{F-}"
else
  if [ "$device" != "" ]; then
    bash -c "echo -e 'power on'
    sleep 0.5
    echo -e \"connect $device\n\"
    sleep 2" | bluetoothctl
  else
    bash -c "echo -e 'power on'
    sleep 0.5" | bluetoothctl
  fi
  echo "%{F#458588}#%{F-}"
fi
