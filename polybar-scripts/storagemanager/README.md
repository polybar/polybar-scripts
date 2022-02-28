# Script: storagemanager

This script displays storage in a certain way you want it to.

![Example](screenshots/1.png)
![Example2](screenshots/2.png)
## Arguments
-h /path/to/mountpoint or /dev/device
-f "{used} {avail} {size} {left}"
### All formats
The names are self-explanatory, but here is a Table Of Contents if you really need it.
Format Name | Description
---|---
{used}       | Used storage
{avail}      | Avalible storage
{size}       | Overall size of the selected partiotion/disk 
{left}       | Left storage

## Module

```ini
[module/storagemanager]
type = custom/script
exec = ~/polybar-scripts/storagemanager.py -h / -f " {used}/{avail} /"
interval = 20
```
