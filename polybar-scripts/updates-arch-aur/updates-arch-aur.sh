 #!/bin/sh

# updates=$(cower -u | wc -l)
updates=$(trizen -Su --aur | wc -l)

if [ "$updates" -gt 0 ]; then
    echo "# $updates"
else
    echo ""
fi
