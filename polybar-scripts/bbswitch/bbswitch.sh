#!/bin/sh
# script created to be used as a module for polybar,
# will tell if the nvidia card is in use or not.

    if [ "$( grep -o "OFF" /proc/acpi/bbswitch )" == "OFF" ]
    then
      echo "Nvidia = Inactive  #1 "
    elif [ "$( grep -o "ON" /proc/acpi/bbswitch )" == "ON" ]
    then
      echo "Nvidia = Active #2 "
    fi
