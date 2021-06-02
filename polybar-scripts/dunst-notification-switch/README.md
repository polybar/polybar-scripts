# Script: dunst-notification-switch

Disable or enable Dunst notifications. When disabled, notifications will still be created and saved by dunst until you enable it again.  

![dunst-notifications-enabled](screenshots/1.png)  
![dunst-notifications-disabled](screenshots/2.png)  


## Dependencies

* [Dunst](https://github.com/dunst-project/dunst)

## Module
```ini
[module/dunst-notification-switch]
type = custom/script
exec = ~/polybar-scripts/dunst-notification-switch.sh
tail = true
click-left = ~/polybar-scripts/dunst-notification-display.sh toggle &
```
