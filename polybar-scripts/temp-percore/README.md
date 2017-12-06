# Script: temp-percore

A script that displays the temperature for each core. You need [lm_sensors](https://archlinux.org/packages/lm_sensors). See the wiki to find out [how to configure](https://wiki.archlinux.org/index.php/lm_sensors) it.

## Module

```
[module/temp-percore]
type = custom/script
exec = ~/polybar-scripts/temp-percore.sh
interval = 60
exec-if = sensors
```
