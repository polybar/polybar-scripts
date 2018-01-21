# Script: system-cpu-temppercore

A script that displays the temperature for each core.

![system-cpu-temppercore](screenshots/1.png)


## Dependencies

You need [lm_sensors](https://archlinux.org/packages/lm_sensors). See the wiki to find out [how to configure](https://wiki.archlinux.org/index.php/lm_sensors) it.


## Module

```ini
[module/system-cpu-temppercore]
type = custom/script
exec = ~/polybar-scripts/system-cpu-temppercore.sh
interval = 60
```
