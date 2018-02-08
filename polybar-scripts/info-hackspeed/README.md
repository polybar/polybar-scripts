# Script: info-hackspeed

A small script that shows the keystrokes per minute. Happy Hacking!

![hackspeedinfo-hac](screenshots/1.png)


## Dependencies

* `xorg-xinput`

They have to set up your keyboard. Replace in line #6 `AT Translated Set 2 keyboard` with your own keyboard description. You can find out your keyboard with `xinput list --short`.

Change `hackspeed_cache` to set another path of the hackspeed cache file.


## Module

```ini
[module/info-hackspeed]
type = custom/script
exec = ~/polybar-scripts/info-hackspeed.sh
tail = true
```
