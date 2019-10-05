# Script: info-dualshock4

A shell script that shows the battery level of a DualShock 4 Controller.

![info-dualshock4](screenshots/1.png)


## Configuration

The Icon is from [Font Awesome 5](https://fontawesome.com/icons/playstation?style=brands).


## Module

```ini
[module/battery-dualshock4]
type= custom/script
exec = ~/polybar-scripts/info-dualshock4.sh
interval = 10
```
