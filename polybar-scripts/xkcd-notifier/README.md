# Script: xkcd-notifier

Displays the current xkcd comic and whether there are any new ones in polybar, written in python.

![Unread](/screenshots/unread.png) ![Read](/screenshots/read.png)

## Dependencies

- Python 3
- [requests](https://pypi.org/project/requests/)

## Configuration

For options see `notifier.py --help`.

## Module

```ini
[module/xkcd]
type = custom/script
exec = ~/.config/polybar/xkcd-notifier/notifier.py -f ~/.config/polybar/xkcd-notifier/latest
click-left =  xdg-open https://xkcd.com/ && ~/.config/polybar/xkcd-notifier/notifier.py -f ~/.config/polybar/xkcd-notifier/latest --read
interval = 60
```

