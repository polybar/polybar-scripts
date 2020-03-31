# Script: info-localip

This script shows the local IP of the current connection.

![info-localip](screenshots/1.png)


## Dependencies

* `route`


## Module

```ini
[module/info-localip]
type = custom/script
exec = ~/polybar-scripts/info-localip.sh
interval = 60
```

