#!/bin/sh

#Replace this variable, Ex: "70:26:06:DD:E1:34"
device=""
R="$(hciconfig)"

#if arguments: current state of the bluetooth
if [ "$#" -ne 0 ]; then
  if echo "$R" | grep -q "UP"; then
    echo "%{F#458588}#%{F-}"
  else
    echo "%{F#888}#%{F-}"
  fi
  exit
fi

# no argument: switching state of the bluetooth
if echo "$R" | grep -q "UP" ; then
  echo "power off" | bluetoothctl > /dev/null
  echo "%{F#888}#%{F-}"
else
  if [ "$device" != "" ]; then
    sh -c "echo 'power on'
    sleep 0.5
    echo  \"connect $device\n\"
    sleep 2" | bluetoothctl > /dev/null
  else
    sh -c "echo 'power on'
    sleep 0.5" | bluetoothctl > /dev/null
  fi
  echo "%{F#458588}#%{F-}"
fi
