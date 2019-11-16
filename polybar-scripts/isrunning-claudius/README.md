# Script: isrunning-claudius

A tiny module to report the state of claudius, the alternative filepicker for Discord.

Left click launches or closes claudius.


## Module

```ini
[module/isrunning-claudius]
type = custom/script
exec = ~/polybar-scripts/isrunning-claudius.sh
interval = 5
click-left = ~/polybar-scripts/isrunning-claudius --toggle &
```
