# Script: vpn-anyconnect-status

Checks if an interface named `cscotun` exists, if not display a red `VPN DISCONNECTED` message. If connected, displays it's IP address.

![connected](screenshots/connected.png)
![disconnected](screenshots/disconnected.png)

## Glyph

Like that glyph? It's 賓 from [FantasqueSansMono](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FantasqueSansMono/Regular/complete)

## Module

```ini
[module/vpn]
type = custom/script
exec = ~/bin/vpnstatus.sh
interval = 3.0
```
