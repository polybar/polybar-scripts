# Script: temp-percore-colorful

A script that displays the temperature for each core in different colors. This is an extension of [temp-percore](../temp-percore/)


## Module

```
[module/temp-percore-colorful]
type = custom/script
exec = ~/polybar-scripts/temp-percore-colorful.sh
interval = 60
exec-if = sensors
```
