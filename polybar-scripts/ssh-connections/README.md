# Script: ssh-sessions

A script that displays the count of current ssh sessions as well as the public IP address of the fist session.

## Module

```ini
[module/ssh-sessions]
type = custom/script
exec = ~/polybar-scripts/ssh-sessions.sh
interval = 5
label = %output%
```
