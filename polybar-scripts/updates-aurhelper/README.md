# Script: updates-aurhelper

A script that shows if there are AUR updates for Arch Linux.


## Dependencies

The possibilities depend on your AUR helper. Not all helpers can report the pending updates.

At the moment `yay`, `trizen`, `pikaur`, `rua` and `cower` are documented. Take a look at the script to see how it works.


## Module

```ini
[module/updates-aurhelper]
type = custom/script
exec = ~/polybar-scripts/updates-aurhelper.sh
interval = 600
```
