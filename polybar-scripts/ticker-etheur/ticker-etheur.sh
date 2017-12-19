#!/bin/sh

rate=$(curl -sf https://api.kraken.com/0/public/Ticker?pair=ETHEUR | jq -r ".result.XETHZEUR.c[0]")
rate=$(LANG=C printf "%.2f" "$rate")

echo "#1 $rate €"
