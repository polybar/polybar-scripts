# Script: info-kernel

A script that shows the running kernel version.


## Module

```ini
[module/system-kernel]
type = custom/script
exec = uname -r
interval = 1024
```
