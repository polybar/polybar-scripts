# Script: dropbox-isrunning

A script that shows if the dropbox client is running. You can also start and stop the client.


## Module

```ini
[module/dropbox-isrunning]
type = custom/script
exec = ~/polybar-scripts/isrunning-dropbox.sh
interval = 5
click-left = ~/polybar-scripts/isrunning-dropbox.sh --toggle &
```
