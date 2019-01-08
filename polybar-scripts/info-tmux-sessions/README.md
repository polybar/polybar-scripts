# Script: info-tmux-sessions

Reports the state of tmux sessions on the local machine.

* with active sessions
![info-tmux-sessions](screenshots/1.png)
* with no server running
![info-tmux-sessions](screenshots/2.png)

## Module

```ini
[module/info-tmux-sessions]
type = custom/script
exec = ~/polybar-scripts/info-tmux-sessions.sh
interval = 3
```
