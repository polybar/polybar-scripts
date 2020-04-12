# Script: info-hackspeed

A small script that shows your typing speed. Happy Hacking!

![info-hackspeed](screenshots/1.png)


## Dependencies

* `xorg-xinput`
* `awk`
* coreutils (`rm`, `stdbuf`, `mktemp`, `stat`, you probably have this)


## Configuration

* `KEYBOARD_ID`: name of your keyboard. See Setup above. Default: `AT Translated Set 2 keyboard`
* `METRIC`: either `cpm` (characters per minute) of `wpm` ([words per minute, 1 word = 5 characters](https://en.wikipedia.org/wiki/Words_per_minute)). Default: `cpm`
* `FORMAT`: format string according to which the metric will be output. Default: `# %d $METRIC`
* `INTERVAL`: amount of seconds to gather data. Default: 20
* `LAYOUT`: keyboard layout, to be able to only count letters and numbers. Currently supported are `qwerty`, `azerty`, `qwertz` and `dvorak`. If you have a different layout, please contribute a condition for it! See the script's source code. Use the special value `dontcare` to count all keys, not just letters and numbers. Default: `qwerty`

If after 20 seconds the value stays at 0 even though you're typing, you may have to configure the name of your keyboard. Change the setting `KEYBOARD_ID` (see Configuration below) in the script. You can find your keyboard description with `xinput list --short`.


## Module

```ini
[module/info-hackspeed]
type = custom/script
exec = ~/polybar-scripts/info-hackspeed.sh
tail = true
```
