# Script: pipewire-control

A script to control pipewire with your mouse buttons and scroll wheel. Uses native pipewire and wireplumber commands. Good for environments where you either can't or don't want to install pulseaudio as a dependency.

## Features

- Scroll to change volume
- Toggle mute with left click
- Middle click to cycle between output devices
- Right click to open `pavucontrol`

## Screenshots

![pipewire-control](screenshots/1.png)
![pipewire-control muted](screenshots/2.png)

## Dependencies

- wireplumber (`wpctl`, `wpexec`)
- ripgrep (`rg`)
- `sd`
- `choose`

## Module

```ini
[module/pipewire-control]
type = custom/script

exec = ~/polybar-scripts/pipewire-control/pipewire-control-tail
tail=true

click-left = ~/polybar-scripts/pipewire-control/pipewire-control toggle-mute
click-middle = ~/polybar-scripts/pipewire-control/pipewire-control next
click-right = exec pavucontrol &

scroll-down = ~/polybar-scripts/pipewire-control/pipewire-control volume down
scroll-up = ~/polybar-scripts/pipewire-control/pipewire-control volume up

# screenshot taken with these settings:
format-prefix = 󰕾
format-underline = #ffb86c
format-prefix-background = #ffb86c
format-prefix-foreground = #282a36
format-prefix-padding = 1

label-background = #44475a
label-foreground = #282a36
label-padding = 1
```
