#!/bin/sh

if [ -z "$KEYBOARD_ID" ]; then
	KEYBOARD_ID="AT Translated Set 2 keyboard"
fi

# cpm: characters per minute
# wpm: words per minute (1 word = 5 characters)
if [ -z "$METRIC" ]; then
	METRIC=cpm
fi

if [ -z "$ICON" ]; then
	ICON="#"
fi

if [ -z "$FORMAT" ]; then
	FORMAT="$ICON %d $METRIC"
fi

if [ -z "$INTERVAL" ]; then
	INTERVAL=20
fi

# If you have a keyboard layout that is not listed here yet, create a condition yourself. $3 is the key index.
# Use `xinput test "AT Translated Set 2 keyboard"` to see key codes in real time.
# Be sure to open a pull request for your layout's condition!
if [ -z "$LAYOUT" ]; then
	LAYOUT=qwerty
fi
if [ -z "$CONDITION" ]; then
	case "$LAYOUT" in
		qwerty) CONDITION='($3 >= 10 && $3 <= 19) || ($3 >= 24 && $3 <= 33) || ($3 >= 37 && $3 <= 53) || ($3 >= 52 && $3 <= 58)'; ;;
		azerty) CONDITION='($3 >= 10 && $3 <= 19) || ($3 >= 24 && $3 <= 33) || ($3 >= 37 && $3 <= 54) || ($3 >= 52 && $3 <= 57)'; ;;
		dontcare) CONDITION='1'; ;; # Just register all key presses, not only letters and numbers
		*) echo "Unsupported layout \"$LAYOUT\""; exit 1; ;;
	esac
fi



# We have to account for the fact we're not listening a whole minute
multiply_by=60
divide_by=$INTERVAL

case "$METRIC" in
	wpm) divide_by=$((divide_by * 5)); ;;
	cpm) ;;
	*) echo "Unsupported metric \"$METRIC\""; exit 1; ;;
esac

hackspeed_cache="$(mktemp -p '' hackspeed_cache.XXXXX)"
trap 'rm "$hackspeed_cache"' EXIT

# Write a dot to our cache for each key press
printf '' > "$hackspeed_cache"
xinput test "$KEYBOARD_ID" | \
	stdbuf -o0 awk '$1 == "key" && $2 == "press" && ('"$CONDITION"') {printf "."}' >> "$hackspeed_cache" &

while true; do
	# Ask the kernel how big the file is with the command `stat`. The number we
	# get is the file size in bytes, which equals the amount of dots the file
	# contains, and hence how much keys were pressed since the file was last
	# cleared.
	lines=$(stat --format %s "$hackspeed_cache")

	# Truncate the cache file so that in the next iteration, we only count new
	# keypresses
	printf '' > "$hackspeed_cache"

	# The shell only does integer operations, so make sure to first multiply and
	# then divide
	value=$(($lines * $multiply_by / $divide_by))

	printf "$FORMAT\n" "$value"

	sleep $INTERVAL
done

# vim: set noet :