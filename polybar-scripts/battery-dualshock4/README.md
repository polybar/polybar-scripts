# Script: battery-dualshock4

A shell script that shows the battery level of the DualShock 4 Controller

## Dependencies

- Font Awesome (Free)

Symbols used:
- https://fontawesome.com/icons/playstation?style=brands
- https://fontawesome.com/icons/unlink?style=solid

## Module

```ini
[module/battery-dualshock4]
type= custom/script
interval = 10
format-prefix = " "
exec = ~/.config/polybar/dualshock.sh

```
