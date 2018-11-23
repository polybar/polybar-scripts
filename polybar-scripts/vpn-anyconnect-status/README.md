# Script: vpn-anyconnect-status

A small script to show the anyconnect status.

If an interface named `cscotun` exists the IP address will be displayed. Otherwise it displays `VPN DISCONNECTED`.

![vpn-anyconnect-status](screenshots/1.png)
![vpn-anyconnect-status](screenshots/2.png)


## Dependencies

* `ifconfig`


## Configuration

You like that icon? It's `賓` from [FantasqueSansMono](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FantasqueSansMono/Regular/complete).


## Module

```ini
[module/vpn-anyconnect-status]
type = custom/script
exec = ~/bin/vpnstatus.sh
interval = 5
```
