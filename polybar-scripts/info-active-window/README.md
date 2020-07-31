# Script: Display current window / application

A shell script that shows your focused window/application
![alt text](https://imgur.com/a/kwV2hYH)
![alt text](https://imgur.com/U74VztC)
![alt text](https://imgur.com/AjGnxoX)

## Dependencies
- xdotool
- WM needs to use the "WM_CLASS" property

## Module

```ini
[module/awindow]
 type = custom/script
 exec = ~/.config/polybar/scripts/window.sh
 tail = true
```
