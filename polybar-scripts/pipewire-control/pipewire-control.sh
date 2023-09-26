#!/usr/bin/env sh

# dependencies: wpctl, ripgrep, sd, choose

getCurrentSink() {
	wpctl inspect "@DEFAULT_AUDIO_SINK@"
}

getCurrentSinkName() {
	getCurrentSink | rg 'node.description' | choose 3 | sd '"' ''
}

getCurrentSinkID() {
	# shellcheck disable=SC2016
	getCurrentSink |
		head -n 1 |
		sd 'id (\d+).*' '$1'
}

getCurrentSinkVolume() {
	# shellcheck disable=SC2016
	wpctl status |
		rg "$(getCurrentSinkID)" |
		sd '.*\[vol: ([\d\.]+)\]' '$1' |
		sd '(\d)\.' '$1' |
		sd '^0{0,2}(\d+)' '$1'
}

listSinks() {
	# shellcheck disable=SC2016
	wpctl status |
		rg --pcre2 --multiline '(?<= Sinks:\n)( │\s*\*?\s*(\d+)\. (\w*).*\n)+' |
		sd '^[\s│\*]+(\d+)\.+\s(\w+(\s?\w+)*).*' '$1 $2'
}

listSinkNames() {
	# shellcheck disable=SC2016
	listSinks | sd '^\d+\s(.*)' '$1'
}

listSinkIDs() {
	# shellcheck disable=SC2016
	listSinks | sd '^(\d+).*' '$1'
}

nextSink() {
	if test "$(listSinks | wc -l)" -eq 1; then
		echo "only one sink"
		exit 1
	fi

	currentSinkID="$(getCurrentSinkID)"
	firstSinkID="$(listSinkIDs | head -n 1)"
	nextSinkID="$(listSinkIDs | rg -A 1 "$currentSinkID" | tail -n 1)"

	if test "$nextSinkID" == "$currentSinkID"; then
		nextSinkID="$firstSinkID"
	fi

	wpctl set-default "$nextSinkID"
}

toggleMute() {
	wpctl set-mute "@DEFAULT_AUDIO_SINK@" toggle
}

adjustVolume() {
	if test "$1" == "up"; then
		wpctl set-volume "@DEFAULT_AUDIO_SINK@" 5%+
	elif test "$1" == "down"; then
		wpctl set-volume "@DEFAULT_AUDIO_SINK@" 5%-
	fi
}

getOutput() {
	printf "$(getCurrentSinkVolume)%% $(getCurrentSinkName)\n"
}

main() {
	case "$1" in
	vol | volume)
		adjustVolume "$2"
		;;
	mute | toggle-mute)
		toggleMute
		;;
	next | cycle)
		nextSink
		;;
	*)
		echo "unknown command"
		exit 1
		;;
	esac
}

main "$@"
