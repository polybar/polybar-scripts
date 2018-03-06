# Script: { Pulseaudio-multi-tail }

This script is a modification on the pulseaudio-tail script.

* Adds icon detection for headphones or speakers on the analog sink
* If you have either HDMI or Bluetooth speakers, detects them and displays their info
* Can use mouse scroll and left-click to edit and mute each sink individually.

## Dependencies & Comments

Copied from the `pulseaudio-tail` script.
I have no idea if its computationally costly;
I would wellcome improvements 

Besides `pulseaudio`, no requirements.
Put `pavol.sh` in your PATH or explicitly replace referances to `pavol.sh` with the commands.
(If put in PATH, other programs can access it too so your volume commands would be pavol.sh -i/d/m 0)
A few things to note;

* The `PA_CRMS` sets the color of the icons. (I use red, so crimson.)
* If your sinks are different hardware, you can add and remove the extra sinks.
Just copy the same structure
* Commented lines contain Font Awesome glyphs. Feel free to replace the preceding lines with them.

## To improve

Don't know if possible, but drag and drop for changing sinks would be a nice feature.

## Module

```ini
[module/volume]
type =                  custom/script
exec =                  $XDG_CONFIG_HOME/polybar/pa-ctl.sh
tail =                  true
click-right =           exec pavucontrol &
```
