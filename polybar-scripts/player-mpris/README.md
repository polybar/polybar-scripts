# Music Player - Basic track info (MPRIS)
![mpris](http://i.imgur.com/3W0zAtq.png)

## Dependencies
* [aur: ttf-font-awesome](https://aur.archlinux.org/packages/ttf-font-awesome/)
* [playerctl](https://github.com/acrisci/playerctl)

## Setup
* Create `~/.config/polybar/mpris.sh` script
```bash
#!/bin/bash

# Specifying the icon(s) in the script
# This allows us to change its appearance conditionally
icon=""

player_status=$(playerctl status 2> /dev/null)
if [[ $? -eq 0 ]]; then
    metadata="$(playerctl metadata artist) - $(playerctl metadata title)"
fi

# Foreground color formatting tags are optional
if [[ $player_status = "Playing" ]]; then
    echo "%{F#D08770}$icon $metadata"       # Orange when playing
elif [[ $player_status = "Paused" ]]; then
    echo "%{F#65737E}$icon $metadata"       # Greyed out info when paused
else
    echo "%{F#65737E}$icon"                 # Greyed out icon when stopped
fi
```

## Module
```ini
[module/music]
type = custom/script
interval = 2

label = %output:0:45:...%
exec = ~/.config/polybar/mpris.sh
click-left = playerctl previous
click-middle = playerctl play-pause
click-right = playerctl next
```
