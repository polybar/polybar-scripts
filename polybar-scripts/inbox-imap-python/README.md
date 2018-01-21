# Script: inbox-imap-python

A script that shows if there are unread mails in your IMAPs inbox.

For Gmail, you must allow [less secure apps](https://myaccount.google.com/security#connectedapps).

![inbox-imap-python](screenshots/1.png)


## Module

```ini
[module/inbox-imap-python]
type = custom/script
exec = ~/polybar-scripts/inbox-imap-python.py
interval = 60
```
