# Script: info-podman

Shows the number of Podman containers in one of the states: `created`, `exited`, `paused`, `running`, `unknown`  

![info-podman](screenshots/1.png)  


## Dependencies

* [`podman`](https://github.com/containers/podman)


## Module
```ini
[module/info-podman]
type = custom/script
exec = ~/polybar-scripts/info-podman.sh
interval = 60
```
