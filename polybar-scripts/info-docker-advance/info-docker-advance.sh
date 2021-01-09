#!/bin/sh

docker_is_active="$(systemctl is-active docker)"

if [ "$docker_is_active" = "active" ]; then
    echo "%{F#3cb703}   : Active: $(docker images -q | wc -l) / $(docker ps -f status=running | tail -n+2 | wc -l) "
else
    echo "%{F#e53935}  : Inactive"
fi

left_click_menu() {

    container="$(docker ps --format \{\{.Names\}\} | rofi -dmenu -window-title 'Running Docker Containers')"
    docker_action=$( printf "TTY\nStop\nPause\nResume\nRemove (force)\nLogs (follow)" | rofi -dmenu -window-title "Container Available Actions")
    case "$docker_action" in
        "TTY")  xterm -fa 'Monospace' -fs 14 -e bash -c "docker exec -it ${container} /bin/sh" 
            ;;
        "Stop") docker stop "${container}"
            ;;
        "Pause") docker pause "${container}"
            ;;
        "Resume") docker unpause "${container}"
            ;;
        "Remove (force)") docker rm -f "${container}"
            ;;
        "Logs (follow)") xterm -fa 'Monospace' -fs 14 -e bash -c "docker logs -f ${container} "
            ;;
        *) echo "Something Else"
           ;;
    esac
}

if [ "$docker_is_active" = "active" ]; then
case "$1" in

rofi-right) docker images --format "{{.Repository}} has the following {{.ID}}" | rofi -dmenu -window-title "Existing Docker Images"
    ;;
rofi-left) left_click_menu ;;
*) echo ""
   ;;
esac
fi
