# Script: info-public-ip

Script returns the Public IP of the current connection.

![skeleton](screenshots/1.png)


## Dependencies

* `curl`


## Module

```ini
[module/info-public-ip]
type = custom/script
exec = ~/polybar-scripts/info-public-ip.sh
interval = 10
```
