# Script: battery-cyberpower

A shell script that shows the battery status for CyberPower UPS devices.

This script is able to display power supply changes in real time.


## Dependencies

* `pwrstat` from CyberPower's website


## Configuration

It requires access to run `pwrstat` as root, so you may need to adjust your system to allow this (for example `sudo`).


## Module

```ini
[module/battery-cyberpower]
type = custom/script
exec = ~/polybar-scripts/battery-cyberpower.sh
tail = true
```
