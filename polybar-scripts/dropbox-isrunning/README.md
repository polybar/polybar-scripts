# Script: dropbox-isrunning

A script that shows if the dropbox client is running. You can also start and stop the client.


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
