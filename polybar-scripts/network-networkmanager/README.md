# Script: network-networkmanager

A shell script that shows the status of NetworkManager.

It shows connection changes in real time.


## Module

```ini
[module/network-networkmanager]
type = custom/script
exec = ~/polybar-scripts/network-networkmanager.sh
tail = true
```
