#!/bin/bash

players=($(playerctl -l))
count=${#players[@]}
change_player () 
{
	if [ $count -gt 0 ];then
		for p in ${players[*]};do
			if [ "$(playerctl status -p $p)" = "Playing" ];then
				echo $p
				export ACTIVE_PLAYER="$p"
				break
			fi
		done
	fi
}

next_player ()
{
	player_no=0
	if [ $count -gt 0 ];then
		for((index=0; index<$count; index++)); do 
			if [ "${players[$index]}" = "$ACTIVE_PLAYER" ]; then
    				player_no=$index
				# echo $player_no
    				break
			fi
		done
		player_no=$((($player_no + 1) % $count))
		echo ${players[$player_no]}
		export ACTIVE_PLAYER="${players[$player_no]}"
	fi
}

change_status ()
{
	# long_status_text=$(playerctl metadata -p $ACTIVE_PLAYER --format '{{artist}} - {{title}} ({{duration(position)}}|{{duration(mpris:length)}})')
	title=$(playerctl metadata -p $ACTIVE_PLAYER --format '{{title}}')
	artist=$(playerctl metadata -p $ACTIVE_PLAYER --format '{{artist}}')
	duration=$(playerctl metadata -p $ACTIVE_PLAYER --format '({{duration(position)}}|{{duration(mpris:length)}})')
	status=$(playerctl -p $ACTIVE_PLAYER status)
	mode=$(playerctl -p $ACTIVE_PLAYER loop)
	if [ "$mode" = "Track" ];then
		mode="[Rpt.]"
	else
		mode=""
	fi
	
	if [ "$status" = "Playing" ];then
        	status=" "
	else
        	status=" "
	fi
	if [ ${#title} -gt 20 ];then
		title="${title:0:20}..."
	fi
	if [ ${#artist} -gt 16 ];then
		artist="${artist:0:15}..."
	fi
	echo "$status$mode $artist - $title $duration"
        #echo "$status$mode $artist - $title"

}

change_mode()
{
	mode=$(playerctl -p $ACTIVE_PLAYER loop)
	if [ "$mode" = "Track" ];then
		playerctl -p $ACTIVE_PLAYER loop None
	else
		playerctl -p $ACTIVE_PLAYER loop Track
	fi
}	

while getopts pnsm option; do
	case "$option" in
		p)
			change_player;;
		n)
			next_player;;
		s)
			change_status;;
		m)
			change_mode;;
	esac
done
