# Script: system-cpu-frequency

A shell script that shows the average core frequency (average over number, not over time) in GHz.


## Module

```ini
[module/system-cpu-frequency]
type = custom/script
interval = 10
exec = ~/polybar-scripts/system-cpu-frequency.sh
```
