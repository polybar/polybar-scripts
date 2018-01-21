# Script: isrunning-compton

A simple script that allows you to toggle compton and shows if it is running.


## Module

```ini
[module/isrunning-compton]
type = custom/script
exec = ~/polybar-scripts/isrunning-compton.sh
interval = 5
click-left = ~/polybar-scripts/isrunning-compton.sh --toggle
```
