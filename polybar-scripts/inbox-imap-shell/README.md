# Script: inbox-imap-shell

A script that shows if there are unread mails in your IMAP inbox.

For Gmail, you must allow [less secure apps](https://myaccount.google.com/security#connectedapps).

This script actually use imaps. `curl` can also handle IMAP or POP3. You only need to change the protocol in the command.


## Dependencies

* `curl`


## Module

```
[module/inbox-imap-shell]
type = custom/script
exec = ~/polybar-scripts/inbox-imap-shell.sh
interval = 60
```
