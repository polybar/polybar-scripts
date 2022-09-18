# Script: network-networkmanager-tail

This script listens for connection up/down status with `nmcli connection monitor` and runs a command.
The command output is then used by polybar.

This script is more flexible than `network-networkmanager`,
doesn't require setting su for `wg` / `wg-quick` if you've set up wireguard with NetworkManager,
and it doesn't poll like `network-networkmanager` (which still polls, but in bash).


## Dependencies

`nmcli` 


## Configuration

```
network-networkmanager-tail.sh: monitor NetworkManager connection status

Usage:
    network-networkmanager-tail.sh [-hcdf] names ...

    Options:
    -h  Displays this message
    -c  Text to print when connected. '✓' by default.
    -d  Text to print when disconnected. "❌" by default.
    -f  Custom print command. '[ "$C_STATE" = "activated"  ] && echo "$TEXT_CONNECTED" || echo "$TEXT_DISCONNECTED"' by default.

    Positional arguments:
        names - the names/UUIDs of the connections to monitor
```

### Print command

The print command is basically a string that gets `eval`ed in a subshell.
It comes with a few shell variables that you can use:

Variables            | Description
---------------------|----------------
`$C_NAME`            | Connection name
`$C_UUID`            | Connection UUID
`$C_STATE`           | Connection state (`activated` or empty)
`$C_TYPE`            | Connection type
`$C_DEVICE`          | Connection device
`$TEXT_CONNECTED`    | Text to show when connected. This can be modified via `-c`.
`$TEXT_DISCONNECTED` | Text to show when disconnected. This can be modified via `-d`.

> with the default print command, text set via `-d` and `-c` can utilise these variables.
> This is an unintended side-effect.

#### Examples:

```sh
# check connectivity with curl
curl -sSL "http://google.com" && echo "$TEXT_CONNECTED" || echo "$TEXT_DISCONNECTED"
```

```sh
# check WARP connectivity (when using wgcf)
# can also use curl -sSL http://cloudflare.com/cdn-cgi/trace
[ wgcf trace 2>/dev/null | grep 'warp=\(plus\|on\)' >/dev/null && echo "$TEXT_CONNECTED" || echo "$TEXT_DISCONNECTED"
```


## Module

### Simple example

```ini
[module/network-networkmanager-tail]
type = custom/script
exec = ~/polybar-scripts/network-networkmanager-tail.sh wlan0
tail = true
```

### Multiple connections

```ini
[module/network-networkmanager-tail]
type = custom/script
exec = ~/polybar-scripts/network-networkmanager-tail.sh wlan0 wlan1 wlan2
tail = true
```

### Custom text

```ini
[module/network-networkmanager-tail]
type = custom/script
exec = ~/polybar-scripts/network-networkmanager-tail.sh -c "Connected!" -d "Disconnected!" wlan0
tail = true
```

### Print command

```ini
[module/network-networkmanager-tail]
type = custom/script
exec = ~/polybar-scripts/network-networkmanager-tail.sh -f 'curl -sSL "http://google.com" && echo "$TEXT_CONNECTED" || echo "$TEXT_DISCONNECTED"' wlan0
tail = true
```

### Fancy colors (requires polybar 3.6.0 and above)

```ini
[module/network-networkmanager-tail]
type = custom/script
exec = ~/polybar-scripts/network-networkmanager-tail.sh -c "%{F$CLR_WHITE}C%{F-}" -d "%{F$CLR_GRAY}D%{F-}" wgcf-profile
tail = true

env-CLR_GRAY = ${color.BGA}
env-CLR_WHITE = ${color.FG}
```
