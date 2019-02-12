# Script: updates-fedora

Checks updates for fedora, and if they're ready or not.  
This script uses colors to show if the updates are staged or ready.  
By default, red=staged, green=ready for installation

This script also requires some modifications, which you can find in the script itself.  
One of which is adding `%users ALL=(ALL) NOPASSWD:/usr/bin/dnf upgrade` to your `/etc/sudoers` file.


![update](screenshots/update.png)


## Module

```ini
[module/updates-fedora]
type = custom/script
exec = ~/polybar-scripts/updates-fedora.sh
format = #  <label>
label = %output%
interval = 600
...
```
