# Script: timew

This script displays the daily tracked time. You can click it, to start tracking, using timew.

## Module

```ini
[module/timew]
type = custom/script
exec = ~/.config/polybar/scripts/timew.sh
interval = 2
click-left = "if timew;then timew stop;else timew start; fi"
```
