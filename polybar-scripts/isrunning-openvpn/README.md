# Script: isrunning-openvpn

A script that shows if OpenVPN is running.


## Module

```
[module/isrunning-openvpn]
type = custom/script
exec = pgrep openvpn
interval = 5
```
