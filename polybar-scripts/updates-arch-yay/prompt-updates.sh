#! /bin/bash
ALL=$(yay -Qu | sed 's/\x1b\[[0-9;]*m//g' | sed 's/->//g' | sed 's/^/TRUE /g')
UPDATE=$(zenity --list \
  --width=500 --height=400 \
  --text="Select updates to install:" \
  --checklist \
  --separator=" " \
  --title="The following pacakges are outdated" \
  --column="Update" --column="Package Name" --column="Previous Version" --column="Current Version" \
  $ALL)
if [[ -z "${UPDATE// }" ]]
then
    exit 1
else
    RESULT=$(termite --name package-update -e "yay -S --noconfirm $UPDATE")
fi
echo "Requesting Update: $UPDATE"
exit 0
