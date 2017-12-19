# Script: pulseaudio-simple

A script that shows the pulseaudio volume.


## Dependencies

* `pamixer`


## Module

```
[module/pulseaudio-simple]
type = custom/script
exec = ~/polybar-scripts/pulseaudio-simple.sh
interval = 3
```
