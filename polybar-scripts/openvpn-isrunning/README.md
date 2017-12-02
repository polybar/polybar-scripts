# Script: openvpn-isrunning

A script that shows if OpenVPN is running.


## Module

```
[module/openvpn-isrunning]
type = custom/script
exec = pgrep openvpn
interval = 5
label = vpn
format-prefix = "# "
```
