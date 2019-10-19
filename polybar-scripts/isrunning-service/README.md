# Script: isrunning-service

A script that shows if a systemd service is running. It uses `journalctl` to get realtime output.


## Configuration

Make sure that your user is member of the group `systemd-journal` to read all events.


## Module

```ini
[module/isrunning-service]
type = custom/script
exec = ~/polybar-scripts/isrunning-service.sh
tail = true
```
