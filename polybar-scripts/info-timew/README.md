# Script: info-timew

This script displays the daily tracked time. You can click it, to start tracking, using timew.

You can use the `--weekday` toggle, to view daily or weekly time spend. (may take the `interval` time to update) 

## Module

```ini
[module/info-timew]
type = custom/script
exec = ~/polybar-scripts/info-timew.sh
interval = 10
click-left = ~/polybar-scripts/info-timew.sh --toggle
click-right = ~/polybar-scripts/info-timew.sh --weekday
```
