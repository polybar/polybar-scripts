# Script: usb-mount

A small script that shows your mounted and not mounted removable devices.

Click left to mount all removable devices. Click right to unmount the devices.
The removable devices are then turned off with `udisksctl power-off`.


## Dependencies

* `jq`
* `udisks2`


## Module

```
[module/usb-mount]
type = custom/script
exec = ~/polybar-scripts/usb-mount.sh
interval = 5
click-left = ~/polybar-scripts/usb-mount.sh --mount
click-right = ~/polybar-scripts/usb-mount.sh --unmount
```
