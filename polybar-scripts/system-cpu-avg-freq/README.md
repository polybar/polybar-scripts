# Script: system-cpu-avg-freq

A shell script that shows the average core frequency (average over number, not over time) (in GHz)

## Module

```ini
[module/system-cpu-avg-freq]
type = custom/script
interval = 1
exec = ~/polybar-scripts/system-cpu-avg-freq/system-cpu-avg-freq.sh
```

