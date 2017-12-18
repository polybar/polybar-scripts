#!/bin/sh

btc=$(curl -sf https://api.kraken.com/0/public/Ticker?pair=BTCEUR | jq -r ".result.XXBTZEUR.c[0]")
btc=$(LANG=C printf "%.2f" "$btc")

echo "#1 $btc €"
