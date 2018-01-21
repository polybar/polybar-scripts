# Script: inbox-pop3-shellnetrc

A script that shows if there are unread mails in your POP3 inbox.

This script actually use POP3s. `curl` can also handle unencrypted POP3. You only need to change the protocol in the command.

The login data is stored in a `.netrc`. This is more secure because the password is not visible in the process list.


## Dependencies

* `curl`


## Module

```ini
[module/inbox-pop3-shellnetrc]
type = custom/script
exec = ~/polybar-scripts/inbox-pop3-shellnetrc.sh
interval = 60
```
