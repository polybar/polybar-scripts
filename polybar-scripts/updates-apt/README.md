# Script: updates-apt

A script that shows if there are updates available through the apt package manager on Ubuntu and Debian-based systems.


## Module

```ini
[module/updates-apt]
type = custom/script
exec = ~/polybar-scripts/updates-apt.sh
interval = 600
```
