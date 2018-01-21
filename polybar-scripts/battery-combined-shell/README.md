# Script: battery-combined-shell

A shell script that shows the battery status.

It supports two rechargeable batteries and changing icons. It works even if only one battery is used.


## Module

```ini
[module/battery-combined-shell]
type = custom/script
exec = ~/polybar-scripts/battery-combined-shell.sh
interval = 10
```
