#!/bin/sh

connection_status() {
    mullvad status | cut -d ' ' -f3 | tr '[:upper:]' '[:lower:]'
}

current_country() {
    mullvad status --location | grep Relay | cut -c8-9
}

list_country_shortcodes() {
    mullvad relay list | grep -v '^[[:blank:]]' | cut -d '(' -f2 | cut -d ')' -f1 | sed '/^$/d'
}

# list_city_shortcodes() {
    # mullvad relay list | grep '^[[:blank:]]' | cut -d '(' -f2 | cut -d ')' -f1 | grep '^[a-z]' | sed '/^$/d'
# }

set_location() {
    mullvad relay set location "${1}"
}

previous_country() {
    list_country_shortcodes | grep "$(current_country)" -B1 | head -n 1 | awk '{printf $0}' 
}

next_country() {
    list_country_shortcodes | grep "$(current_country)" -A1 | tail -n 1 | awk '{printf $0}' 
}

case $1 in
	"status") connection_status;;
	"location") current_country;;
	"toggle")
	    if [ "$(connection_status)" = "connected" ]; then
	        mullvad disconnect
	    else
	        mullvad connect
	    fi
	    ;;
	"reconnect") mullvad reconnect;;
	"previous") set_location "$(previous_country)";;
	"next") set_location "$(next_country)";;
esac
