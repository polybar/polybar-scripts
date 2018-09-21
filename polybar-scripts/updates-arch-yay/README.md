# Script: updates-arch-yay

A script that shows if there are updates for Arch Linux and/or AUR updates.

See also [updates-arch](../updates-arch), [updates-arch-aur](../updates-arch-aur) and [updates-arch-combined](../updates-arch-combined).


## Dependencies

* `yay`


## Module

### Show only updates to the repositories (like `updates-arch`)

```ini
[module/updates-arch-yay]
type = custom/script
exec = ~/polybar-scripts/updates-arch-yay.sh arch
interval = 600
```

### Show only updates to the AUR (like `updates-arch-aur`)

```ini
[module/updates-arch-yay]
type = custom/script
exec = ~/polybar-scripts/updates-arch-yay.sh aur
interval = 600
```

### Show updates to both the repositories and the AUR (like `updates-arch-combined`)

```ini
[module/updates-arch-yay]
type = custom/script
exec = ~/polybar-scripts/updates-arch-yay.sh
interval = 600
```

### Show a different text before the number

```ini
[module/updates-arch-yay]
type = custom/script
exec = ~/polybar-scripts/updates-arch-yay.sh aur '↺ '
interval = 600
```
