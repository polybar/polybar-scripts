# Script: bbswitch

A shell script created to be used as a module for polybar,
will tell if the nvidia card is in use or not.
You can add an icon in the script where it is # 1 and # 2, or edit it any way you like.

* Only for notebook users with a dedicated NVIDIA card and an Intel graphics card.


## Dependencies
* [bbswitch](https://github.com/Bumblebee-Project/bbswitch)

## Script
```

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

```
## Module

```
[module/bbswitch_show]
type = custom/script
interval = 5
format = <label>
click-left = "optirun -b none nvidia-settings -c :8"
exec = ~/polybar-scripts/polybar-scripts/bbswitch/bbswitch.sh

```
