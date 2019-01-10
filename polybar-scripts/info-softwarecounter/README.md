# Script: info-softwarecounter

A script that counts the number of specified running software including GUIs and processes.

Options to only monitor GUI applications or only processes exist. Users can add their own applications or processes they wish to watch simply by updating the existing dictionaries at the start of the script.

Arbitrary program counts can be combined, for example, the vim/nvim or chrome/chromium counts can be added together and the total displayed.

![info-softwarecounter](screenshots/1.png)


## Dependencies

* `wmctrl`
* `pgrep`


## Module

```
[module/info-softwarecounter]
type = custom/script
exec = ~/polybar-scripts/info-softwarecounter.py
interval = 10
```
