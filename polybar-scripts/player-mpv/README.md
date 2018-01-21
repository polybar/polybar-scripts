# mpv

## Dependencies
* [mpv](https://mpv.io/)

## Setup
Create `~/.config/polybar/mpv.sh` script.

```bash
#!/bin/bash
ARTIST=$(ps -u | less | grep -v vim | grep -v grep | grep 'mpv' | head -n1 | cut -d '-' -f 3- | cut -d ' ' -f 2- | cut -d '-' -f -1 | head -c -2)
SONG=$(ps -u | less | grep -v vim | grep -v grep | grep 'mpv' | head -n1 | cut -d '-' -f 3- | cut -d ' ' -f 2- | cut -d '-' -f -2 | cut -d '-' -f 2- | tail -c +2)

FULL=$(ps -u | less | grep -v vim | grep -v grep | grep 'mpv' | head -n1 | cut -d '-' -f 3- | cut -d ' ' -f 2- | cut -d '-' -f -2 | head -c -2)

#echo -n "$ARTIST - $SONG"
echo -n "$FULL"
```

## Module

```ini
[module/mpv]
type = custom/script

exec = sh ~/.config/polybar/mpv.sh
exec-if = pgrep -x mpv
interval = 1

format = <label>
label = %output%
```
