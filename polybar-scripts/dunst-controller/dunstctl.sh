#! /usr/bin/env sh

unmute() {
    dunstctl set-paused false && \
        dunstify 'dunst' 'Unmuted notifications.' -i polari -u low &
}

mute() {
    dunstify 'dunst' 'Muting notifications...' -i polari -u low &
    # We're about to mute notifications, so the above notification will
    # effectively not show, since set-paused hides notifications. So, sleep
    # for 2 seconds.
    sleep 2
    # Close all to prevent notification from showing up once we unmute.
    dunstctl close-all
    dunstctl set-paused true
}

pop_all() {
    for id in $(dunstctl history | while jq -r '.data[][].id.data'); do
        dunstctl history-pop $id
    done
}

if [ "$(dunstctl is-paused)" = 'true' ]; then
    case $1 in
    toggle)
        unmute
        ;;
    show-all)
        unmute
        pop_all
        ;;
    *)
        echo " $(dunstctl count waiting)"
        ;;
    esac
else
    case $1 in
    toggle)
        mute
        ;;
    show-all)
        pop_all
        ;;
    *)
        echo ''
        ;;
    esac
fi
