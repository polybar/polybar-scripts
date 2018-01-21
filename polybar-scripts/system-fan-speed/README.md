# Script: system-fan-speed

A shell script which displays the fan speed.


## Dependencies

You need [lm_sensors](https://archlinux.org/packages/lm_sensors). See the wiki to find out [how to configure](https://wiki.archlinux.org/index.php/lm_sensors) it.


## Module

```ini
[module/system-fan-speed]
type = custom/script
exec = ~/polybar-scripts/system-fan-speed.sh
interval = 10
```
