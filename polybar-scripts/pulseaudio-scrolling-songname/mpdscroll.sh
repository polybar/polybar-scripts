#!/bin/sh
#Script to scroll song name of current mpd song in polybar
thresh=20
if ! mpc >/dev/null 2>&1; then
    echo Server offline
    exit 1
elif mpc status | grep -q playing; then
    if [ `mpc current | wc -c` -gt "$thresh" ]; then
        ( zscroll -l "$thresh" -d 0.30 -b "" -a "" -p " /// " -u true "mpc current"  | sed -e :a -ue "s/^.\{1,$thresh\}$/& /;ta" | sed -uEn 's/(^.*$)/───| \1|───/p' ) &
    else
        ( echo `mpc current` | sed -uEn 's/(^.*$)/───|\1|───/p' ) &
    fi
elif mpc status | grep -q paused; then
    echo "───| Paused |───"
else
    echo "───| Stopped |───"
fi

mpc idle >/dev/null

    #( zscroll -l 20 -d 0.30 -b "" -a "" -p " /// " -u true "mpc current"  use zscroll to scroll the output of mpc current with /// as the delim between the end of text
    #| sed -e :a -ue 's/^.\{1,20\}$/& /;ta'#pad with space to be 20 chars if not
    #| sed -uEn 's/(^.*$)/───| \1|───/p' surround text in ───| |─── for asthetic
    #) & capture, run in background
