# Script: mail-imap

A script that shows if there are unread mails in your IMAP inbox.

For Gmail, you must allow [less secure apps](https://myaccount.google.com/security#connectedapps).


## Module

```
[module/mail-imap]
type = custom/script
exec = ~/polybar-scripts/mail-imap.py
interval = 60
```
