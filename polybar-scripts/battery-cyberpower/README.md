# Script: battery-cyberpower

A shell script that shows the battery status for CyberPower UPS devices.

This script is able to display power supply changes in real time.


## Dependencies

* `pwrstat` from CyberPower's website


## Configuration

You have to add the `pwrstat` command to the `/etc/sudoers` NOPASSWD of your user:

```ini
user ALL=(ALL) NOPASSWD: /usr/bin/pwrstat
```


## Module

```ini
[module/battery-cyberpower]
type = custom/script
exec = ~/polybar-scripts/battery-cyberpower.sh
tail = true
```
