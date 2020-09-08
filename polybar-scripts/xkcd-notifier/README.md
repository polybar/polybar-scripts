# xkcd-notifier

Displays the current xkcd comic and whether there are any new ones in polybar, written in python.
For options see `notifier --help`.

![Unread](/screenshots/unread.png) ![Read](/screenshots/read.png)

## Dependencies

- Python 3
- [requests](https://pypi.org/project/requests/)
- [siji](https://github.com/stark/siji/) for the default prefix

## Module

```
[module/xkcd]
type = custom/script
exec = ~/.config/polybar/xkcd-notifier/notifier.py -f ~/.config/polybar/xkcd-notifier/latest
click-left = xdg-open https://xkcd.com/ && ~/.config/polybar/xkcd-notifier/notifier.py -f ~/.config/polybar/xkcd-notifier/latest --read
interval = 300
```

