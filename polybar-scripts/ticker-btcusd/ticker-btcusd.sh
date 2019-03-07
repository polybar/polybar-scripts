#!/bin/sh

rate=$(curl -sf https://api.kraken.com/0/public/Ticker?pair=XBTUSD | jq -r ".result.XXBTZUSD.c[0]")
rate=$(LANG=C printf "%.2f" "$rate")

echo "BTC $rate $"
