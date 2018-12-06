# Script: updates-arch-aur

A script that shows if there are AUR updates for Arch Linux.


## Dependencies

The possibilities depend on your AUR helper. Not all helpers can report the pending updates.

At the moment `yay`, `trizen` and `cower` are documented. Take a look at the script to see how it works.


## Module

```ini
[module/updates-arch-aur]
type = custom/script
exec = ~/polybar-scripts/updates-arch-aur.sh
interval = 600
```
