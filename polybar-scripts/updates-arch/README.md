# Script: updates-arch

A script that shows if there are updates for arch.
There are other ways to display updates for AUR packages like [cower -u](https://aur.archlinux.org/packages/cower/). But it depends on your AUR helper.


## Module

```
[module/updates-arch]
type = custom/script
exec = ~/polybar-scripts/updates-arch.sh
interval = 600
```
