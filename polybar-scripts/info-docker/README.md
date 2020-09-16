# Script: info-docker

Shows the number of Docker containers in one of the states: `created`, `restarting`, `running`, `removing`, `paused`, `exited`, `dead`

![info-docker](screenshots/1.png)


## Configuration

You have to add the `docker` command to the `/etc/sudoers` NOPASSWD of your user:

```ini
user ALL=(ALL) NOPASSWD: /usr/bin/docker ps -qf status=running
user ALL=(ALL) NOPASSWD: /usr/bin/docker ps -qf status=exited
user ALL=(ALL) NOPASSWD: /usr/bin/docker ps -qf status=dead
```


## Module

```ini
[module/info-docker]
type = custom/script
exec = ~/polybar-scripts/info-docker.sh
interval = 60
```
