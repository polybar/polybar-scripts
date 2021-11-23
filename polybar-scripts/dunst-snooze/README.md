# Script: dunst-snooze

A script to disable/enable Dunst notifications. When disabled, notifications will still be created and saved by dunst until you enable it again.  

![dunst-pause](screenshots/1.png)
![dunst-pause](screenshots/2.png)  


## Module
```ini
[module/dunst-snooze]
type = custom/script
exec = ~/polybar-scripts/dunst-snooze.sh
interval = 10
click-left = ~/polybar-scripts/dunst-snooze.sh --toggle &
```
