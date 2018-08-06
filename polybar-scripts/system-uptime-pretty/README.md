# Script: system-uptime-pretty

A shell script which displays the output of `uptime --pretty` in a minimal fashion:

`2d 1h 35m`


## Module

```ini
[module/system-uptime-pretty]
type = custom/script
exec = ~/polybar-scripts/system-uptime-pretty.sh
interval = 30
```
