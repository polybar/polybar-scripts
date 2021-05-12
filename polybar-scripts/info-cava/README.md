# Script: info-cava

A simple script that runs a small audio visualizer using cava on your taskbar

![info-cava](screenshots/1.png)


## Dependencies

* [`cava`](https://github.com/karlstav/cava)


## Configuration

Configuration can be made by providing the following command line arguments:
* `-f`|`--framerate FRAMERATE` : Framerate to be used by cava, default is 60.
* `-b`|`--bars BARS`:  Amount of bars, default is 8.
* `-e`|`--extra_colors EXTRA_COLORS`: Color gradient used on higher values, separated by commas, default is `fdd,fcc,fbb,faa`, spaces and #s are ignored.
* `-c`|`--channels {stereo,left,right,average}`: Audio channels to be used, defaults to stereo.


## Module

```ini
[module/info-cava]
type = custom/script
exec = ~/polybar-scripts/info-cava.py -f 24 -b 12 -e fffdfc,fffafe,ffeafa,ffc3d2 -c average
tail = true
```
