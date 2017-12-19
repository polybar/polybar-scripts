#!/bin/sh

rate=$(curl -sf https://api.kraken.com/0/public/Ticker?pair=BCHEUR | jq -r ".result.BCHEUR.c[0]")
rate=$(LANG=C printf "%.2f" "$rate")

echo "#1 $rate €"
