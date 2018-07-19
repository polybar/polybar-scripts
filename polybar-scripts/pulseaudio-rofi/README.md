# Script: pulseaudio-rofi

This script displays the current volume for input/output. Allows to adjust volume, mute.  
Uses rofi menu to change current output/input devices.

![pulseaudio-rofi](screenshots/1.png)

![pulseaudio-rofi](screenshots/2.png)


## Dependencies

* PulseAudio [pacmd, pactl] (https://github.com/pulseaudio/pulseaudio)
* Rofi (https://github.com/DaveDavenport/rofi)


## Module

```ini

[module/pulseaudio-output]
type = custom/script

format = <label>
label =  %output%

exec = ~/.config/polybar/pulseaudio-rofi.sh --output_volume_listener
tail = true
click-right = ~/.config/polybar/pulseaudio-rofi.sh --output
click-left = ~/.config/polybar/pulseaudio-rofi.sh --mute
scroll-up =  ~/.config/polybar/pulseaudio-rofi.sh --volume_up
scroll-down = ~/.config/polybar/pulseaudio-rofi.sh --volume_down

[module/pulseaudio-input]
type = custom/script

format = <label>
label =  %output%

exec = ~/.config/polybar/pulseaudio-rofi.sh --input_volume_listener
tail = true
click-right = ~/.config/polybar/pulseaudio-rofi.sh --input
click-left = ~/.config/polybar/pulseaudio-rofi.sh --mute_source
scroll-up =  ~/.config/polybar/pulseaudio-rofi.sh --volume_source_up
scroll-down = ~/.config/polybar/pulseaudio-rofi.sh --volume_source_down

```
