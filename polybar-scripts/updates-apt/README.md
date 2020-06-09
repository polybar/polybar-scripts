# Script: updates-apt

A script that retrieves update information and shows if there are updates available through the apt package manager on Ubuntu and Debian-based systems.

## Dependencies
```bash
  sudo apt install -y packagekit-tools
```

## Module

```ini
[module/updates-apt]
type = custom/script
exec = ~/polybar-scripts/updates-apt.sh
interval = 600
```
