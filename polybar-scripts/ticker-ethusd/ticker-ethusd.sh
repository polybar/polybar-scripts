#!/bin/sh

rate=$(curl -sf https://api.kraken.com/0/public/Ticker?pair=ETHUSD | jq -r ".result.XETHZUSD.c[0]")
rate=$(LANG=C printf "%.2f" "$rate")

echo "ETH $rate $"
