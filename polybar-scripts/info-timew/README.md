# Script: timew

This script displays the daily tracked time. You can click it, to start tracking, using timew.

## Module

```ini
[module/timew]
type = custom/script
exec = ~/.config/polybar/scripts/info-timew.sh
interval = 10
click-left = "~/.config/polybar/scripts/info-timew.sh toggle"
```
