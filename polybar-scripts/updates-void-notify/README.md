# Script: updates-void-notify

Script that shows if there are updates for Void Linux and also by means of a pop-up message it shows the first six updates of the list.

# Module

```ini
[module/updates-void-notify]
type = custom/script
exec = ~/polybar-scripts/updates-void-notify.sh
interval = 600
```