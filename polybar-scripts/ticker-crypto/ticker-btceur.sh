#!/bin/sh

rate=$(curl -sf https://api.kraken.com/0/public/Ticker?pair=BTCEUR | jq -r ".result.XXBTZEUR.c[0]")
rate=$(LANG=C printf "%.2f" "$rate")

echo "#1 $rate €"
