# Script: updates-arch-yay

A script that shows the total available updates for Arch Linux using Yay.


## Dependencies

Requires 'yay'.

## Module

```ini
[module/updates-arch-aur]
type = custom/script
exec = ~/polybar-scripts/updates-arch-yay/updates-arch-yay.sh
interval = 600
```
