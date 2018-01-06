# cmus
![cmus module](http://i.imgur.com/DhnQFrC.png)

## Dependencies
* [cmus](http://cmus.github.io/)

## Setup
Create `~/.config/polybar/cmus.sh` script. The script prepends a 0, to keep the total output length constant.

```bash
#!/bin/bash

cmusstatus=$(cmus-remote -C status)
grep position <<< "$cmusstatus" 1>/dev/null 2>&1
if [ ! $? -eq 0 ]; then exit; fi

strindex() {
  x="${1%%$2*}"
  [[ "$x" = "$1" ]] && echo -1 || echo "${#x}"
}

prepend_zero () {
    seq -f "%02g" $1 $1
}

get_all_but_first() {
  shift
  echo "$@"
}

get_stat() {
  line=$(grep "$1" -m 1 <<< "$cmusstatus")
  a=$(strindex "$line" "$1")
  sub="${line:a}"
  echo "$(get_all_but_first $sub)"
}

min_sec_from_sec() {
  echo -n "$(prepend_zero $(($1 / 60))):$(prepend_zero $(($1 % 60)))"
}

echo -n "$(get_stat artist)  -  $(get_stat title)  [$(min_sec_from_sec $(get_stat position)) / $(min_sec_from_sec $(get_stat duration))]"
```

## Module
```ini
[module/cmus]
type = custom/script

exec = sh ~/.config/polybar/cmus.sh
exec-if = pgrep -x cmus
interval = 1

click-left = cmus-remote --pause
click-right = cmus-remote --stop
```
