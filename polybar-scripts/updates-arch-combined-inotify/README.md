# Script: updates-arch-combined-inotify

A script that uses [inotify-tools](https://www.archlinux.org/packages/community/x86_64/inotify-tools/) to update the status after pacman and yay transactions. It watches the directories /var/lib/pacman.d/sync and "$XDG_CACHE_HOME/yay" for file events and updates the package counts when pacman or yay is finished.

It can also be poked with a `USR1` signal to trigger an update:

```
pkill -USR1 updates-arch-combined-inotify.sh
```

Otherwise, checks every 15 minutes for a list of updates.

See also [updates-arch](../updates-arch), [updates-arch-aur](../updates-arch-aur) and [updates-arch-combined](../updates-arch-combined).

![updates-arch-combined-inotify](screenshots/1.png)


## Dependencies

* `pacman-contrib`
* `yay`
* `inotify-tools`

## Module

```ini
[module/updates-arch-combined]
type = custom/script
exec = ~/polybar-scripts/updates-arch-combined-inotify.sh
tail = true
click-left = pkill -USR1 updates-arch-combined-inotify.sh
```
