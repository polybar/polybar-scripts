# Script: info-xampp

The Script prints the status of [XAMPP](https://www.apachefriends.org/de/index.html) services (Apache, MySQL, ProFTPD) if they are running.

![info-xampp](screenshots/1.png)


## Configuration

You have to add the `xampp` command to the `/etc/sudoers` NOPASSWD of your user:

```ini
user ALL=(ALL) NOPASSWD: /opt/lampp/xampp
```


## Module

```ini
[module/info-xampp]
type = custom/script
exec = ~/polybar-scripts/info-xampp.sh
interval = 10
```
