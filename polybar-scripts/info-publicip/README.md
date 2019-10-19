# Script: info-publicip

This script shows the public IP of the current connection.

![info-publicip](screenshots/1.png)


## Dependencies

* `curl`


## Module

```ini
[module/info-publicip]
type = custom/script
exec = ~/polybar-scripts/info-publicip.sh
interval = 60
```
