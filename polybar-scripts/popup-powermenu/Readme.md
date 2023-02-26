
# Script: popup-powermenu
A popup menu made with Yad that provides a window giving options to shutdown, reboot, logout etc..


## Requirements

This script assumes you have installed the [yad](https://github.com/v1cont/yad) package installed.


## Configuration



Change these commands for your particular system, or add your own custom options as well:

```sh
case $action in
    Shutdown*) cmd="poweroff" ;;
    Reboot*) cmd="reboot" ;;
    Logout*) cmd="echo logout";;
    Suspend*) cmd="echo suspend" ;;
    *) exit 1 ;;    
esac

```

Add this module to your polybar config:


```ini
[module/powermenu]
type = custom/text
content = " "
content-foreground = ${color.alert}
click-left = /path-where-script-is-saved/powermenu.sh &

```
Change the path name and the icon as you require.
Finally add the module to the bar.

