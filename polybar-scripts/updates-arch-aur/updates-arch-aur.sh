 #!/bin/sh

# if ! updates=$(cower -u 2> /dev/null); then
if ! updates=$(trizen -Su --aur 2> /dev/null); then
    updates=0
else
    updates=$(echo $updates | wc -l)
fi

if [ "$updates" -gt 0 ]; then
    echo "# $updates"
else
    echo ""
fi
