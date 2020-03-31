# Script: updates-fedora

A script that shows if there are updates for Fedora or `dnf` based distributions.

![updates-fedora](screenshots/1.png)

## Configuration

You can choose the `dnf` command used to retrieve the update information by 
changing the number at the end of the `exec` line. Currently, there's two modes:

1. updateinfo (default)
   Shows uninstalled updates but doesn't show new dependencies
2. update
   Shows uninstalled updates and new dependencies

For the second mode, you have to add the `dnf` command to the `/etc/sudoers` 
NOPASSWD of your user:

```
user ALL=(ALL) NOPASSWD: /usr/bin/dnf
```

## Module

```ini
[module/updates-fedora]
type = custom/script

format = <label>
label = %output%

exec = ~/polybar-scripts/updates-fedora.sh 1
interval = 600
```
