# Script: inbox-imap-shellpass

A script that shows if there are unread mails in your IMAP inbox.

This script actually use IMAPs. `curl` can also handle unencrypted IMAP. You only need to change the protocol in the command.

The login data can be stored in your `pass` password manager.


## Dependencies

* `curl`


## Module

```ini
[module/inbox-imap-shellpass]
type = custom/script
exec = ~/polybar-scripts/inbox-imap-shellpass.sh
interval = 60
```
