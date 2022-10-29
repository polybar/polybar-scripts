#!/bin/sh

tzcount=1

print_date() {
  TZ=$(sed -n ${tzcount}p ~/.config/polybar/timezones) date +"%I:%M %p" | echo "$(sed -n ${tzcount}p ~/.config/polybar/timezones): $(cat -)"
}

update_tzcount() {
  num_tz=$(wc -l ~/.config/polybar/timezones | awk '{print $1}')
   if [ "$tzcount" -eq "$num_tz" ] 
   then 
     tzcount=1
   else 
     tzcount=$((tzcount+1))
   fi

}

click() {
  update_tzcount
  print_date
}

trap "click" USR1

while true; do
  print_date
  sleep 5 &
  wait
done


