# Pomodoro timer
![pomodoro_running](https://i.imgur.com/Ruyo7ZL.png)

## Dependencies
* [aur:pymodoro-git](https://aur.archlinux.org/packages/pymodoro-git/)
* [aur:nerd-fonts-complete](https://aur.archlinux.org/packages/nerd-fonts-complete/) Optional to get nice looking glyphs

## Setup
* Modify the following module to your needs, the command line parameters for the exec line can be found in pymodoro repo
* Change the icons to your needs (the commented exec uses the pomicons glyphs as in the Nerd fonts collection)

## Module
```ini
[module/pomodoro]
type = custom/script
; Use pomodoro glyphs in Nerd fonts
; exec = pymodoro --break-prefix " " --pomodoro-prefix " " --pomodoro  --empty  --break  --length 5
; Use default symbols
exec = pymodoro --length 5
label = %output%
tail = true
interval = 0
; Start or reset the timer
click-left = if [ -e ~/.pomodoro_session ]; then rm ~/.pomodoro_session; else echo "25 5" > ~/.pomodoro_session; fi
; Increase pomodoro time
click-right = echo "$((`cut .pomodoro_session -d ' ' -f 1`+5)) 5" > .pomodoro_session
; Reduce pomodoro time
click-middle = echo "$((`cut .pomodoro_session -d ' ' -f 1`-5)) 5" > .pomodoro_session
```
## Usage
* Left click starts or stops/resets the timer
* Right click increases the pomodoro time by 5 minutes
* Middle click decreases the pomodoro time by 5 minutes
