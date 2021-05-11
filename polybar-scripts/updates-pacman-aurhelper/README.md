# Script: updates-pacman-aurhelper

A script that shows if there are updates for Arch Linux and AUR updates.

See also [updates-pacman](../updates-pacman) and [updates-aurhelper](../updates-aurhelper).

![updates-pacman-aurhelper](screenshots/1.png)


## Dependencies

* `pacman-contrib`

The possibilities depend on your AUR helper. Not all helpers can report the pending updates.

At the moment `yay`, `paru`, `trizen`, `pikaur`, `rua` and `cower` are documented. Take a look at the script to see how it works.


## Module

```ini
[module/updates-pacman-aurhelper]
type = custom/script
exec = ~/polybar-scripts/updates-pacman-aurhelper.sh
interval = 600
```
