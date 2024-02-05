# Script: vpn-tun-status

A script that shows the IP address for each active tun adapter.

![vpn-tun-status](screenshots/1.png)
![vpn-tun-status](screenshots/2.png)


## Dependencies

* `jq`


## Module

```ini
[module/vpn-tun-status]
type = custom/script
exec = ~/polybar-scripts/vpn-tunX-ip.sh
interval = 10
```
