# Script: inbox-imap-shell

A script that shows if there are unread mails in your IMAP inbox.

This script actually use IMAPs. `curl` can also handle unencrypted IMAP. You only need to change the protocol in the command.


## Dependencies

* `curl`


## Configuration

For Gmail, you must allow [less secure apps](https://myaccount.google.com/security#connectedapps).


## Module

```ini
[module/inbox-imap-shell]
type = custom/script
exec = ~/polybar-scripts/inbox-imap-shell.sh
interval = 60
```
