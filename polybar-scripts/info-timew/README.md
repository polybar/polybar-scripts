# Script: info-timew

This script displays the daily tracked time. You can click it, to start tracking, using timew.


## Module

```ini
[module/info-timew]
type = custom/script
exec = ~/polybar-scripts/info-timew.sh
interval = 10
click-left = ~/polybar-scripts/info-timew.sh --toggle
```
