# qmmp - info & control
![qmmp](http://i.imgur.com/KBfpCYT.png)

## Setup
* Create `~/.config/polybar/qmmp.sh` script
```bash
#!/bin/bash
status=`qmmp --nowplaying '%p - %t'`
if [[ $status == "-" ]]
then
    echo "Stopped"
else
    echo "$status"
fi
```

## Module

```ini
[module/qmmp]
type = custom/script
exec = ~/.config/polybar/qmmp.sh
exec-if = pgrep -x qmmp
click-left = qmmp -t
click-right = qmmp --next
interval = 5
```
