# Script: system-cpu-temppercore-colorful

A script that displays the temperature for each core in different colors.

This is an extension of [system-cpu-temppercore](../system-cpu-temppercore/).


## Dependencies

You need [lm_sensors](https://archlinux.org/packages/lm_sensors). See the wiki to find out [how to configure](https://wiki.archlinux.org/index.php/lm_sensors) it.


## Module

```
[module/system-cpu-temppercore-colorful]
type = custom/script
exec = ~/polybar-scripts/system-cpu-temppercore-colorful.sh
interval = 60
exec-if = sensors
```
