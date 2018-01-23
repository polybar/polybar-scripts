# Script: info-xampp

The Script prints the status of [XAMPP](https://www.apachefriends.org/de/index.html) services (Apache, MySQL, ProFTPD) if they are running.

![info-xampp](screenshots/1.png)


## Module

```ini
[module/info-xampp]
type = custom/script
exec = ~/polybar-scripts/info-xampp.sh
interval =
```

## Troubleshooting

To show the MySQL Server status, the script must own a file in /opt/lampp/var/MySQL.
To solve this I edited the xampp script in /opt/lampp/ in the startMySQL() function, ![MySQL Troubleshooting](screenshots/xampp-mysql.png) <br>
The sleep is imported because the file need some time to create.
The file is owned by the mysql user. May you can fix that problem on Otherwise. This is only one solution.
