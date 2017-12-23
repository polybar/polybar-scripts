# Script: compton-isrunning

A simple script that allows you to toggle compton and shows if it is running.


## Module

```
[module/compton-isrunning]
type = custom/script
exec = ~/polybar-scripts/compton-isrunning.sh
interval = 5
click-left = ~/polybar-scripts/compton-isrunning.sh --toggle
```
