# Script: info-kernel

A script that shows the running kernel version.


## Module

```ini
[module/info-kernel]
type = custom/script
exec = uname -r
interval = 1024
```
