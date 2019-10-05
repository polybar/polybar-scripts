# Script: info-taskspooler

A small script that displays the number of queues/runtimes for one or more task spooler servers.

![info-taskspooler](screenshots/1.png)


## Dependencies

* `task-spooler`


## Configuration

By default the script will output the count of the default task-spooler server.

Arguments can be passed to show custom task-spooler servers by using the `TS_SOCKET variable`. These custom servers will need to use a socket filename format like /tmp/ts-socket.SOCK_NAME or the script will be unable to find the server. Arguments are passed as `name,sock_name` with sock_name being optional, e.g. `default yt,youtube p,podcast`.


## Module

```ini
[module/info-taskspooler]
type = custom/script
exec = ~/polybar-scripts/info-task-spooler/info-taskspooler.sh
# exec = ~/polybar-scripts/info-taskspooler/info-taskspooler.sh default yt,youtube p,podcast
interval = 5
```
