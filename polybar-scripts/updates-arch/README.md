# Script: updates-arch

A script that shows if there are updates for Arch Linux.


## Dependencies

* `pacman-contrib`


## Module

```ini
[module/updates-arch]
type = custom/script
exec = ~/polybar-scripts/updates-arch.sh
interval = 600
```
