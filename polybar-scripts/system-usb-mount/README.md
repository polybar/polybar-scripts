# Script: system-usb-mount

A small script that shows your mounted and not mounted removable devices.

Click left to mount all removable devices. Click right to unmount the devices. The removable devices are then turned off with `udisksctl power-off`.

The mount option has a feature: You can also start a file manager and open the device when you mount it. Look at the example in the code: `terminal -e "bash -lc 'filemanager $mountpoint'"`

![system-usb-mount](screenshots/1.png)

![system-usb-mount](screenshots/2.png)


## Dependencies

* `jq`
* `udisks2`


## Module

```
[module/system-usb-mount]
type = custom/script
exec = ~/polybar-scripts/system-usb-mount.sh
interval = 5
click-left = ~/polybar-scripts/system-usb-mount.sh --mount
click-right = ~/polybar-scripts/system-usb-mount.sh --unmount
```
