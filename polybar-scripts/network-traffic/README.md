# Script: network-traffic

A script that displays the current network traffic.

It allows you to count traffic from more then one interface.


## Dependencies

* `bc`


## Configuration

Change the values in `INTERVAL` and `INTERFACES`.


## Module

```ini
[module/network-traffic]
type = custom/script
exec = ~/polybar-scripts/network-traffic.sh
tail = true
```
