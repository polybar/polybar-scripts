# Script: updates-arch-combined

A script that shows if there are updates for Arch Linux and AUR updates.


## Dependencies

The possibilities depend on your AUR helper. Not all helpers can report the pending updates.

See also [updates-arch](../updates-arch) and [updates-arch-aur](../updates-arch-aur).


## Module

```
[module/updates-arch-combined]
type = custom/script
exec = ~/polybar-scripts/updates-arch-combined.sh
interval = 600
```
