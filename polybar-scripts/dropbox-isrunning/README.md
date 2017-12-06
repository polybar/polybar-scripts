# Script: dropbox-isrunning

A script that shows if Dropbox is running.


## Module

```
[module/dropbox-isrunning]
type = custom/script
exec = ~/polybar-scripts/dropbox-isrunning.sh
interval = 5
label = vpn
format-prefix = "# "
click-left = ~/.config/polybar/dropbox toggle
tail = true
```
