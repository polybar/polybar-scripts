# Script: wmname

This script prints the value of the environment variable wmname

## Dependencies

The BSPWM window manger, and maybe some more, has some problems with java scaling
To solve this you can change the environment variable wmname in something different.
See here: https://wiki.archlinux.org/index.php/java#Impersonate_another_window_manager

Dependencies: wmname



## Module

```
[module/wmname]
type = custom/script
interval = 2
label = %output%
exec = ~/./.skript/wmname.sh
click-right = ~/./.skript/wmname.sh --toggle
click-left = ~/./.skript/wmname.sh --toggle
```
