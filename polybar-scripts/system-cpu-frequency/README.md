# Script: system-cpu-frequency

A shell script which displays the cpu frequency.


## Dependencies

* `cpupower`


## Module

```ini
[module/system-cpu-loadavg]
type = custom/script
exec = ~/polybar-scripts/system-cpu-frequency.sh
interval = 5
```
