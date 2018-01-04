# Script: claudius-isrunning

A tiny module to report the state of claudius, the alternative filepicker for Discord.

Left click launches or closes claudius.


## Module

```
[module/claudius-isrunning]
type = custom/script
exec = ~/polybar-scripts/claudius-isrunning.sh
interval = 5
click-left = ~/polybar-scripts/claudius-isrunning.sh --toggle
```
