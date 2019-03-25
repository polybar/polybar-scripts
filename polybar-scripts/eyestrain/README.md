# Script: eyestrain

A script for avoiding digital eye strain. It follows the 20-20-20 rule. The timer displays how long it is until the next break.

You can add this to send a notification and play a sound when the time is up:

```bash
if [[ $time -eq 20 ]]
then
    notify-send 'Break' &
    ogg123 beep.ogg &> /dev/null &
fi
```

## Module

```ini
[module/eyestrain]
type = custom/script
exec = ~/polybar-scripts/eyestrain.sh
interval = 60
```
