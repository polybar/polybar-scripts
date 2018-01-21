# Script: system-uptime-pretty

A shell script which displays the output of `uptime --pretty` in a minimal fashion.

The default output of `uptime --pretty` is formatted as `up 2 days, 1 hour, 35 minutes`. This is fairly verbose for something like a status bar where space is precious. Therefore, this script utilizes sed to change this output to something more minimal:

`2d 1h 35m`


## Module

```ini
[module/system-uptime-pretty]
type = custom/script
exec = ~/polybar-scripts/system-uptime-pretty.sh
interval = 30
```
