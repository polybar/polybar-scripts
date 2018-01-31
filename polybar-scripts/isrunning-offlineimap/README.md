# Script: isrunning-offlineimap

A script that shows if offlineimap is running. The scripts require you to have setup offlineimap yourself.


## Module

```ini
[module/offlineimap-isrunning]
type = custom/script
exec = ~/polybar-scripts/offlineimap-isrunning.sh
interval = 5
click-left = ~/polybar-scripts/offlineimap-isrunning.sh --toggle
```
