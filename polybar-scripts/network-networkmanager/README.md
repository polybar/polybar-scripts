# Script: network-networkmanager

A shell script that shows the status of NetworkManager.

It shows connection changes in real time.


## Configuration

Copy `90-polybar` to `/etc/NetworkManager/dispatcher.d/90-polybar`. Make sure that the paths in the file have been modified properly. The script needs to be executable.
If you want the left click functionality, uncomment the option and replace `yourterminal` with the name of the terminal that you are using.


## Module

```ini
[module/network-networkmanager]
type = custom/script
exec = ~/polybar-scripts/network-networkmanager.sh
tail = true
;left-click= yourterminal -e 'nmtui' & 
```
