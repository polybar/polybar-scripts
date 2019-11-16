# Script: player-mpris-tail

This script displays the current track and the play-pause status without polling. Information is obtained by listening to MPRIS events, so it is updated instantaneously on change.

![player-mpris-tail](screenshots/1.png) ![player-mpris-tail](screenshots/2.png)


## Dependencies

* `python-dbus`
* `python-gobject`
* `python-gi`


## Configuration

The format of the output can be defined by passing an `-f` or `--format` argument. This argument supports metadata replacement using `{tag}` (e.g. `{title}`) as well as more advanced formatting, described below.

Players can be blacklisted by passing a `-b` or `--blacklist` argument. As an example, VLC can be blacklisted by passing `-b vlc`. To get a list of the current running players (and their status), run the script as `player-mpris-tail.py list`.


### Commands

The current player can be controlled by passing one of the following commands:

Command | Description
---|---
play       | Play the current track
pause      | Pause the currently playing track
play-pause | Play the current track or unpause it if currently paused
stop       | Stop playback
previous   | Move to the previous track
next       | Move to the next track
raise      | Tell the current player to focus its window

General information about the current state can be printed using the following commands:

Command | Description
---|---
status   | Print the normal output and exit immediately
current  | Print the currently detected player and its status
list     | List the detected players and their status
metadata | Print the metadata object for the current track


### Arguments

The following arguments are supported:

Argument | Description | Default
---|---|---
-b, --blacklist   | Blacklist / Ignore the given player
-f, --format      | Use the given `format` string                               | `{icon} {artist} - {title}`
--truncate-text   | Use the given string as the end of truncated text           | `…`
--icon-playing    | Use the given text as the playing icon                      | `⏵`
--icon-paused     | Use the given text as the paused icon                       | `⏸`
--icon-stopped    | Use the given text as the stopped icon                      | `⏹`
--icon-none       | Use the given text as the icon for when no player is active | ``


### Formatting

Tags can be printed by surrounding them with `{` and `}`. Polybar formatting can also be given and will be passed through, including substituted tags and formatters.


### Tags

The supported tags are:

Tag | Description
---|---
artist        | The artist of the current track
album         | The album of the current track
title         | The title of the current track
track         | The track number of the current track
length        | The length of the current track
genre         | The genre of the current track
disc          | The disc number of the current track
date          | The date of the current track
year          | The year of the current track
cover         | The URL of the cover of the current track
icon          | The icon for the current status (playing / paused / stopped / none)
icon-reversed | The pause icon when playing, else the play icon


### String formatters

Parts of the `format` string can be manipulated by surrounding them with `{:` and `:}` and prepending a formatter followed by a `:` (e.g. `{:t20:by {artist}:}`)

The following formatters are supported:

Formatter | Argument | Description | Example | Output
---|---|---|---|---
`tag` | | Only print the string if `tag` exists            | `{:album: on {album}:}` | ` on Album Name`
w     | Number | Limit the width of the string to `number` | `{:w3:Hello:}`          | `Hel`
t     | Number | Truncate width of the string to `number`. If the string is shorter than or equal to `number` it is printed as given, else the string is truncated and appended a truncator text | `{:t3:Hello:}` | `He…`


## Module

### Basic output

```ini
[module/player-mpris-tail]
type = custom/script
exec = ~/polybar-scripts/player-mpris-tail.py -f '{icon} {artist} - {title}'
tail = true
```

Example: `⏵ Artist - Title`


### Basic output and mouse controls

```ini
[module/player-mpris-tail]
type = custom/script
exec = ~/polybar-scripts/player-mpris-tail.py -f '{icon} {artist} - {title}'
tail = true
click-left = ~/polybar-scripts/player-mpris-tail.py previous &
click-right = ~/polybar-scripts/player-mpris-tail.py next &
click-middle = ~/polybar-scripts/player-mpris-tail.py play-pause &
```

Example: `⏵ Artist - Title`


### Output using formatters

```ini
[module/player-mpris-tail]
type = custom/script
exec = ~/polybar-scripts/player-mpris-tail.py -f '{icon} {:artist:t5:{artist}:}{:artist: - :}{:t4:{title}:}'
tail = true
click-left = ~/polybar-scripts/player-mpris-tail.py previous &
click-right = ~/polybar-scripts/player-mpris-tail.py next &
click-middle = ~/polybar-scripts/player-mpris-tail.py play-pause &
```

Example: `⏵ Artis… - Titl…` or `⏵ Titl…`


### Output using formatters and Polybar action handlers

```ini
[module/player-mpris-tail]
type = custom/script
exec = ~/polybar-scripts/player-mpris-tail.py -f '{icon} {:artist:t18:{artist}:}{:artist: - :}{:t20:{title}:}  %{A1:~/polybar-scripts/player-mpris-tail.py previous:} ⏮ %{A} %{A1:~/polybar-scripts/player-mpris-tail.py play-pause:} {icon-reversed} %{A} %{A1:~/polybar-scripts/player-mpris-tail.py next:} ⏭ %{A}'
tail = true
```

Example: `⏵ Artis… - Titl…   ⏮  ⏸  ⏭ ` or `⏵ Titl…   ⏮  ⏸  ⏭ ` or `⏸ Titl…   ⏮  ⏵  ⏭ `


### Output using formatters, Polybar action handlers and blacklisting

```ini
[module/player-mpris-tail]
type = custom/script
exec = ~/polybar-scripts/player-mpris-tail.py -f '{icon} {:artist:t18:{artist}:}{:artist: - :}{:t20:{title}:}  %{A1:~/polybar-scripts/player-mpris-tail.py previous -b vlc -b plasma-browser-integration:} ⏮ %{A} %{A1:~/polybar-scripts/player-mpris-tail.py play-pause -b vlc -b plasma-browser-integration:} {icon-reversed} %{A} %{A1:~/polybar-scripts/player-mpris-tail.py next -b vlc -b plasma-browser-integration:} ⏭ %{A}' -b vlc -b plasma-browser-integration
tail = true
```

Example: `⏵ Artis… - Titl…   ⏮  ⏸  ⏭ ` or `⏵ Titl…   ⏮  ⏸  ⏭ ` or `⏸ Titl…   ⏮  ⏵  ⏭ `
