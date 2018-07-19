# Script: inbox-imap-python

A script that shows if there are unread mails in your IMAPs inbox.

![inbox-imap-python](screenshots/1.png)


## Configuration

For Gmail, you must allow [less secure apps](https://myaccount.google.com/security#connectedapps).


## Module

```ini
[module/inbox-imap-python]
type = custom/script
exec = ~/polybar-scripts/inbox-imap-python.py
interval = 60
```
