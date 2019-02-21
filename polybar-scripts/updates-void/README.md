# Script: updates-void
See number of updates available on Void Linux.

## Configuration
If `xbps-install -Sun` returns 'ERROR: Failed to initialize libxbps: Permission denied' this module won't work.
To fix that you'll need to add updates-void.sh to your sudoers file:

```
username ALL=(ALL) NOPASSWD: /home/username/polybar-scripts/updates-void.sh
```
and change the module to use `sudo`:
```
exec = sudo ~/polybar-scripts/updates-void.sh
```


## Module
```ini
[module/updates-void]
type = custom/script
exec = ~/polybar-scripts/updates-void.sh
interval = 180
```
