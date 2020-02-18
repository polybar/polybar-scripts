#!/bin/bash

# The amount to increase/decrease volume by
increment_amount=2

# Set ramp icons
icon_1=1
icon_2=2
icon_3=3
icon_4=4
icon_muted=0

# Progress bar configuration
bar_color_filled="#dfe1e8"
bar_color_not_filled="#2b303b"
bar_glyph="#"
bar_number_of_glyphs="50" # How many divisions there will be in the progress bar

# Play the volume change sound
play_sound() {
  canberra-gtk-play -i audio-volume-change
}

# Get the current volume
volume() {
  pamixer --get-volume --sink "$sink"
}

# Find current sink
update_sink() {
  sink=$(pacmd list-sinks | sed -n '/\* index:/ s/.*: //p')
}

# Progress bar
# From https://github.com/Fabian-G/dotfiles/blob/master/scripts/bin/getProgressString
# Usage: progress_bar <TOTAL ITEMS> <FILLED LOOK> <NOT FILLED LOOK> <STATUS>
progress_bar() {
  local items="$1"           # The total number of items(the width of the bar)
  local filled_item="$2"     # The look of a filled item
  local not_filled_item="$3" # The look of a not filled item
  local status="$4"          # The current progress status in percent

  # Calculate how many items need to be filled and not filled
  local filled_items
  filled_items=$(echo "((${items} * ${status})/100 + 0.5) / 1" | bc)
  local not_filled_items
  not_filled_items=$(echo "$items - $filled_items" | bc)

  # Assemble the bar string
  local msg
  msg=$(printf "%${filled_items}s" | sed "s| |${filled_item}|g")
  msg=${msg}$(printf "%${not_filled_items}s" | sed "s| |${not_filled_item}|g")
  echo "$msg"
}

# Notification content
notification() {
  local title="Volume notification"
  local filled_item="<span foreground='$bar_color_filled'>$bar_glyph</span>"
  local not_filled_item="<span foreground='$bar_color_not_filled'>$bar_glyph</span>"
  local id=54902 # Unique ID so the notification gets replaced on update
  # Usage: progress_bar <TOTAL ITEMS> <FILLED LOOK> <NOT FILLED LOOK> <STATUS>
  dunstify "$title" "$(progress_bar "$bar_number_of_glyphs" "$filled_item" "$not_filled_item" "$(volume)")" -r "$id"
}

# Main output function
output() {
  if [[ "$(pamixer --get-volume-human --sink "$sink")" = "muted" ]]; then
    echo "$icon_muted  0%"
  elif [[ "$(volume)" -ge 0 ]] && [[ "$(volume)" -le 24 ]]; then
    echo "$icon_1  $(volume)"%
  elif [[ "$(volume)" -ge 25 ]] && [[ "$(volume)" -le 49 ]]; then
    echo "$icon_2  $(volume)"%
  elif [[ "$(volume)" -ge 50 ]] && [[ "$(volume)" -le 74 ]]; then
    echo "$icon_3  $(volume)"%
  elif [[ "$(volume)" -ge 75 ]] && [[ "$(volume)" -le 100 ]]; then
    echo "$icon_4  $(volume)"%
  fi
}

# Change volume functions
volume_up() {
  pamixer --sink "$sink" --increase "$increment_amount"
}

volume_down() {
  pamixer --sink "$sink" --decrease "$increment_amount"
}

volume_mute() {
  pamixer --sink "$sink" --toggle-mute
}

# Wait for change to volume, and the update output
listen() {
  pactl subscribe | grep --line-buffered "sink" | while read -r; do
    output;
  done
}

# What happens when each option is used
case "$1" in
  --up)
    update_sink
    volume_up
    notification
    if [[ "$(volume)" -lt 100 ]]; then
      play_sound
    fi
    ;;
  --down)
    update_sink
    volume_down
    notification
    if [[ "$(volume)" -gt 0 ]]; then
      play_sound
    fi
    ;;
  --mute)
    update_sink
    volume_mute
    play_sound
    ;;
  *)
    update_sink
    output
    listen
    ;;
esac
