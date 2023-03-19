# Script: popup-powermenu

A popup menu made with Yad that provides a window giving options to shutdown, reboot, logout.


## Dependencies

* [`yad`](https://sourceforge.net/projects/yad-dialog/)


## Module

```ini
[module/popup-powermenu]
type = custom/script
exec = ~/polybar-scripts/popup-powermenu.sh
interval = 5
click-left = ~/polybar-scripts/popup-powermenu.sh --popup &
```
