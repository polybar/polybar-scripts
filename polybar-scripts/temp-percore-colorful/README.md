# Script: temp-percore-colorful

A script that displays the temperature for each core in different colors. This is an extension of [temp-percore](../temp-percore/). You need [lm_sensors](https://archlinux.org/packages/lm_sensors).

See the wiki to find out [how to configure](https://wiki.archlinux.org/index.php/lm_sensors) it.


## Module

```
[module/temp-percore-colorful]
type = custom/script
exec = ~/polybar-scripts/temp-percore-colorful.sh
interval = 60
exec-if = sensors
```
