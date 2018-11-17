# Script: anyconnect-status

Checks if an interface named `cscotun` exists, if not display a red
`VPN DISCONNECTED` message. If connected, displays it's IP address.

![connected](screenshots/connected.png)
![disconnected](screenshots/disconnected.png)

## Color and glyph

The contribution guidelines require colors to be stripped. Like the screen
shots? Here's the exact script:

```bash
#!/usr/bin/env bash

IFACE=$(ifconfig | grep cscotun | awk '{print $1}')

if [[ $IFACE == "cscotun"* ]];
then
    echo "%{u#55aa55}$(ifconfig cscotun0 | grep inet | awk '{print $2}' | cut -f2 -d':')%{u-}"
else
    echo '%{F#FF0000}%{u#FF0000}VPN DISCONNECTED%{u-}%{F-}'
fi
```

Like that glyph? It's 賓 from [FantasqueSansMono](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FantasqueSansMono/Regular/complete)

## Module

```ini
[module/vpn]
type = custom/script
exec = ~/bin/vpnstatus.sh
format-prefix = "#1 "
interval = 3.0
```
