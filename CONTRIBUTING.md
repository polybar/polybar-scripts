# Contributing to polybar-scripts

Thank you for your interest in improving polybar-scripts.

Some things that have become standard:

* The [skeleton](skeleton/). This is an example of how each script is organized to create a common file structure.
* Use `#` or `#1`, `#2` .. as icon replacement in your scripts. Everyone use another icon font. So let the user decide which icon he wants to use.
* Remove your colors unless they have a special function. This way scripts remain customizable.


## check your code

* Use `shellcheck` to check your shell scripts for possible errors. Otherwise, Travis CI will do it for you. A good start to try [ShellCheck](https://www.shellcheck.net/) is their website.
