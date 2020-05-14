# Script: updates-pacman

A script that shows if there are updates for pacman-based distributions like Arch Linux or Manjaro.


## Dependencies

* `pacman-contrib`


## Module

```ini
[module/updates-pacman]
type = custom/script
exec = ~/polybar-scripts/updates-pacman.sh
interval = 600
```
