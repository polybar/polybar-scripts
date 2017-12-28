#!/bin/sh

devices=$(lsblk -Jplno NAME,TYPE,RM,SIZE,MOUNTPOINT,VENDOR)


case "$1" in
    --mount)
        for mount in $(echo $devices | jq -r '.blockdevices[]  | select(.type == "part") | select(.rm == "1") | select(.mountpoint == null) | .name'); do
            udisksctl mount --no-user-interaction -b $mount
        done
        ;;
    --unmount)
        for unmount in $(echo $devices | jq -r '.blockdevices[]  | select(.type == "part") | select(.rm == "1") | select(.mountpoint != null) | .name'); do
            udisksctl unmount --no-user-interaction -b $unmount
            udisksctl power-off --no-user-interaction -b $unmount
        done
        ;;
    *)
        output=""
        for unmounted in $(echo $devices | jq -r '.blockdevices[]  | select(.type == "part") | select(.rm == "1") | select(.mountpoint == null) | .name'); do
            unmounted=$(echo $unmounted | tr -d "[:digit:]")
            unmounted=$(echo $devices | jq -r '.blockdevices[]  | select(.name == "'$unmounted'") | .vendor')
            unmounted=$(echo $unmounted | tr -d ' ')

            output="$output $unmounted   "
        done

        for mounted in $(echo $devices | jq -r '.blockdevices[] | select(.type == "part") | select(.rm == "1") | select(.mountpoint != null) | .size'); do
            output="$output $mounted   "
        done

        echo "$output"
        ;;
esac
