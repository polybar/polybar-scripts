# Script: updates-fwupd

A script that shows if there are firmware updates available.


## Dependencies

* `fwupd`


## Module

```ini
[module/updates-fwupd]
type = custom/script
exec = ~/polybar-scripts/updates-fwupd.sh
interval = 3600
```
