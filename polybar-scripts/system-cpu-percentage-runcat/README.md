# Script: system-cpu-percentage-runcat

A python script which displays CPU usage and an animated cat according to the percentage.

![runcat](screenshots/0.png)
![runcat](screenshots/1.png)
![runcat](screenshots/2.png)
![runcat](screenshots/3.png)
![runcat](screenshots/4.png)


## Dependencies

- Python 3
- psutil (module for Python 3)
- speedcpu.py (just include the file in your polybar scripts folder)
- data.json (just include the file in your polybar scripts folder)

## Configuration

You must add the new font to your system and include it in the Polybar config file. The font includes the icons for the cat. Just add the .ttf file to /usr/share/fonts and run fc-cache in shell.

## Module

```ini
[module/runcat]
type = custom/script
exec = ~/polybar-scripts/system-cpu-runcat.py
interval = 0.02
```
Thanks to [Takuto Nakamura](https://github.com/Kyome22/menubar_runcat) for cat images and [Sergei Kolesnikov](https://github.com/win0err/gnome-runcat) for Gnome Version.
