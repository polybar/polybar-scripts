# Script: info-usbtoserial

A small script which shows the USB-to-Serial converters that are connected.

This script is able to display device changes in real time. For this udev is being used.


## Configuration

Copy `95-usbtoserial.rules` to `/etc/udev/rules.d/95-usbtoserial.rules`. Make sure that the paths in the file have been modified properly.


## Module

```ini
[module/info-usbtoserial]
type = custom/script
exec = ~/polybar-scripts/info-usbtoserial.sh
tail = true
```
