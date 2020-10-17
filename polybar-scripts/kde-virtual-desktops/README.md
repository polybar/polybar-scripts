# Script: kde-virtual-desktops

A collection of scripts for managing KDE virtual desktops.

`kde-virtual-desktops` will automatically detect your KWin virtual desktops
and highlight your active one, either by name or number. `kde-next-desktop`
and `kde-previous-desktop` will switch your active desktop to the next or
previous one.

![Module with desktop names](screenshots/1.png)

![Module with desktop numbers](screenshots/2.png)

## Configuration

`kde-virtual-desktops` configuration is done inside the script:
```bash
### Configuration
accentColor="#ff79c6" # text color of active desktop
separator="|"         # separator string in between desktop names or numbers
useDesktopNames=false # set to true to use desktop names instead of numbers
###
```

## Module

```ini
[module/kde-virtual-desktops]
type = custom/script
exec = ~/.config/polybar/scripts/kde-virtual-desktops
scroll-up = ~/.config/polybar/scripts/kde-previous-desktop
scroll-down = ~/.config/polybar/scripts/kde-next-desktop
tail = true
label = %output%
```
