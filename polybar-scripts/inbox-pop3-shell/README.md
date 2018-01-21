# Script: inbox-pop3-shell

A script that shows if there are unread mails in your POP3 inbox.

This script actually use POP3s. `curl` can also handle unencrypted POP3. You only need to change the protocol in the command.


## Dependencies

* `curl`


## Module

```ini
[module/inbox-pop3-shell]
type = custom/script
exec = ~/polybar-scripts/inbox-pop3-shell.sh
interval = 60
```
