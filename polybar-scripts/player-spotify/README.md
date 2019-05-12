# Script: player-spotify

A bash script that shows the current playing song in Spotify and buttons to control it.

![spotify](screenshots/spotify.png)

The leftmost button is play/pause, then previous song, next song and finally stop/pause.

## Dependencies

- Font Awesome (Free)

Symbols used:
- https://fontawesome.com/icons/spotify?style=brands
- https://fontawesome.com/icons/step-forward?style=solid
- https://fontawesome.com/icons/fast-backward?style=solid
- https://fontawesome.com/icons/fast-forward?style=solid
- https://fontawesome.com/icons/stop?style=solid

## Module

```ini
[module/player-spotify]
type = custom/script
interval = 1
format = <label>
format-prefix = " "
label = %{T7}%{A1:dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause &> /dev/null:}  %{A}%{A1:dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous &> /dev/null:}  %{A}%{A1:dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next &> /dev/null:}  %{A}%{A1:dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop &> /dev/null:}  %{A}%{T-} | %output:0:70:...%
format-prefix-foreground = #1ed760
format-underline = #1ed760
exec = dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | awk -F 'string "' '/string|array/ {printf "%s",$2; next}{print ""}' | awk -F '"' '/artist/ {a=$2} /title/ {t=$2} END{print a " - " t}'
exec-if = pgrep -x spotify
```
