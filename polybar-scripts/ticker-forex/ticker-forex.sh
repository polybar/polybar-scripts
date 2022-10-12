#!/bin/sh

API="https://api.exchangeratesapi.io/latest"

CURRENCY_BASE="EUR"
CURRENCY_QUOTE="PLN"

quote=$(curl -sf "$API?base=$CURRENCY_BASE&symbols=$CURRENCY_QUOTE" | jq -r ".rates.$CURRENCY_QUOTE")
quote=$(LANG=C printf "%.2f" "$quote")


echo "# $quote"
