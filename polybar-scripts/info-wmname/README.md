# Script: info-wmname

This script prints the value of the window manager name property of the root window.

The BSPWM window manger, and maybe some more, has some problems with java scaling. To solve this you can [set the value of the window manager name property](https://wiki.archlinux.org/index.php/java#Impersonate_another_window_manager) to something different.


## Dependencies

* `wmname`


## Module

```ini
[module/info-wmname]
type = custom/script
exec = ~/polybar-scripts/info-wmname.sh
interval = 5
click-left = ~/polybar-scripts/info-wmname.sh --toggle
```
