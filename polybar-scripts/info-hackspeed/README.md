# Script: info-hackspeed

A small script that shows your typing speed. Happy Hacking!

![hackspeedinfo-hac](screenshots/1.png)


## Dependencies

* `xorg-xinput`
* `awk`
* coreutils (`rm`, `stdbuf`, `mktemp`, `stat`, you probably have this)

## Module

```ini
[module/info-hackspeed]
type = custom/script
exec = ~/polybar-scripts/info-hackspeed.sh
tail = true
```

## Setup

You may have to set up your keyboard. Set the environment variable KEYBOARD_ID (see Configuration below) or change the default value in the script. You can find your keyboard description with `xinput list --short`.

## Configuration

* `KEYBOARD_ID`: name of your keyboard. See Setup above. Default: `AT Translated Set 2 keyboard`
* `METRIC`: either `cpm` (characters per minute) of `wpm` ([words per minute, 1 word = 5 characters](https://en.wikipedia.org/wiki/Words_per_minute)). Default: `cpm`
* `ICON`: label to prefix to the count. Default: `#`
* `FORMAT`: format string according to which the metric will be output. Default: `$ICON %d $METRIC`
* `INTERVAL`: amount of seconds to gather data. Default: 20
* `LAYOUT`: keyboard layout, to be able to only count letters and numbers. Currently supported are `qwerty` and `azerty`. If you have a different layout, please contribute a condition for it! See the script's source code. Use the special value `dontcare` to count all keys, not just letters and numbers. Default: `qwerty`

