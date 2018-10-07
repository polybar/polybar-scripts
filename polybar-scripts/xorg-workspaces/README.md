# Script: Workspaces

A small script to show what workspace you are on using xprop.
Feel free to modify it to your prefrences.

![polybar-scripts/workspaces] (screenshots/1.png)


## Dependencies

Requires Xprop


## Configuration

The characters for the active and inactive workspaces are modifiable
in the script using the variables __CURRENT__ and __INACTIVE__.


## Module

```ini
[module/workspaces]
type = custom/script
exec = ~/polybar-scripts/workspaces.sh
interval = 0.01
```
