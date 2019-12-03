# Script: updates-flatpak

A script that shows if there are updates for FlatPak.


## Dependencies

* `flatpak` to run `flatpak update`


## Module

```ini
[module/updates-flatpak]
type = custom/script
exec = ~/polybar-scripts/updates-flatpak.sh
interval = 600
```
