# Trash
![trash](http://i.imgur.com/meMb27p.png)

## Dependencies
* Sound event "trash-empty.oga" (if want)
* [aur: ttf-font-awesome](https://aur.archlinux.org/packages/ttf-font-awesome/)

## Setup
* Create `~/.config/polybar/trash` script
```bash
#!/bin/bash

TRASH_DIRECTORY="${BLOCK_INSTANCE}"

if [[ "${TRASH_DIRECTORY}" = "" ]]; then
  TRASH_DIRECTORY="${XDG_DATA_HOME:-${HOME}/.local/share}/Trash"
fi

# Left click
if [[ "${BLOCK_BUTTON}" -eq 1 ]]; then
  xdg-open "${TRASH_DIRECTORY}/files"
# Right click
elif [[ "${BLOCK_BUTTON}" -eq 3 ]]; then
  # Delete all files permanently (unlink them)
  rm -r "${TRASH_DIRECTORY}/files"
  rm -r "${TRASH_DIRECTORY}/info"
  exec paplay ~/.sounds/freedesktop/stereo/trash-empty.oga
  # Create new directory
  mkdir "${TRASH_DIRECTORY}/files"
  mkdir "${TRASH_DIRECTORY}/info"
fi

TRASH_COUNT=$(ls -U -1 "${TRASH_DIRECTORY}/files" | wc -l)

URGENT_VALUE=30

echo "${TRASH_COUNT}"
echo "${TRASH_COUNT}"
echo ""

if [[ "${TRASH_COUNT}" -ge "${URGENT_VALUE}" ]]; then
  exit 31
fi
```

## Module
```ini
[module/trash]
interval = 1
type = custom/script
exec = ~/.config/polybar/trash
format-prefix = " "
click-right = rm -rf ~/.local/share/Trash/files/* ;exec paplay ~/.sounds/freedesktop/stereo/trash-empty.oga
click-left = pcmanfm ~/.local/share/Trash/files
```

## How it works
* Click-left open trash
* Click-right clean the trash
