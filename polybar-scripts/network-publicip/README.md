# Script: network-publicip

This script shows the public IP of the current connection.

![network-publicip](screenshots/1.png)


## Dependencies

* `curl`


## Module

```ini
[module/network-publicip]
type = custom/script
exec = ~/polybar-scripts/network-publicip.sh
interval = 60
```
