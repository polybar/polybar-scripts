#!/bin/sh
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m' # No Colour

echo -e "${BLUE} Please enter your WakaTime API token ${NC}"

read token

echo -e "${BLUE} Please enter the password you will use to decrypt your WakaTime API key and make a note of it.${NC}"

read pubPswd

echo ${token} | openssl enc -aes-256-cbc -md sha512 -a -pbkdf2 -iter 100000 \
-salt -pass pass:${pubPswd} > secret.txt
chmod 600 secret.txt

echo -e "${GREEN} Your token has been encrypted and written to the file secret.txt ${NC}"


# https://www.linuxtechi.com/encrypted-password-bash-shell-script>/