# Script: player-spotify

Displays current song and controls.

![player-spotify](screenshots/1.png)


## Dependencies

- Spotify
- dbus


## Module

```ini
[module/spotify]
type= custom/script
exec = ~/.config/polybar/spotify.sh
label =/ %{A1:dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous:}<%{A} %{A1:dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause:} %output% %{A} %{A1:dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next:}>%{A}
format = <label>
tail = true
interval = 1
...
```
