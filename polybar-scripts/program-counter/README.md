# Program Counter

Counts the number of specified running programs including GUIs and processes.

Options to only monitor GUI applications or only processes exist.  Users can add
their own applications or processes they wish to watch simply by updating the
existing dictionaries at the start of the script. Arbitrary program counts can
be combined, for example, the vim/nvim or chrome/chromium counts can be added
together and the total displayed.

## Example uses

* Seeing how many terminals or web browsers are running.
* Checking if a system updater is running, or finished.
* Seeing how many open SSH connections are running.

## Screenshot
![Program counter](program-counter.png)

Example showing the status bar when:

* 6 terminals,
* 2 Chrome/Chromium,
* 1 Firefox,
* 1 Teamviewer,
* 1 PDF viewer,
* 1 Vim,
* 2 SSH, and
* 1 package manager

sessions are running.


## Requirements

* wmctrl
* pgrep

### Font

* [Material Design Icons](https://materialdesignicons.com/)

## Polybar config

```
[module/program-counter]
type = custom/script
exec = ~/.config/polybar/program-counter.py
interval = 8
```
