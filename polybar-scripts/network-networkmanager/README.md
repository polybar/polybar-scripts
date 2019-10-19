# Script: network-networkmanager

A shell script that shows the status of NetworkManager.

It shows connection changes in real time.


## Configuration

Copy `90-polybar` to `/etc/NetworkManager/dispatcher.d/90-polybar`. Make sure that the paths in the file have been modified properly. The script needs to be executable.


## Module

```ini
[module/network-networkmanager]
type = custom/script
exec = ~/polybar-scripts/network-networkmanager.sh
tail = true
```
