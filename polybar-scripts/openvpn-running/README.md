# Script: openvpn-running

A script that shows if OpenVPN is running.


## Module

```
[module/openvpn-running]
type = custom/script
exec = pgrep openvpn
interval = 5
label = vpn
format-prefix = "# "
```
