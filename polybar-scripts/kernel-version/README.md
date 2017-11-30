# Script: kernel-version

A script that shows the running kernel version.


## module config

```
[module/kernel-version]
type = custom/script
exec = uname -r
interval = 1024
```
