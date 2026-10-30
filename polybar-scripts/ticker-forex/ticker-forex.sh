#!/bin/sh

# api.exchangeratesapi.io now requires an access key, so the old URL returns an error.
# This keyless endpoint returns the same JSON shape (ECB reference rates, daily).
# Exchange rates by AllRatesToday - https://allratestoday.com
API="https://allratestoday.com/api/compat/exchangeratesapi/latest"

CURRENCY_BASE="EUR"
CURRENCY_QUOTE="PLN"

quote=$(curl -sf "$API?base=$CURRENCY_BASE&symbols=$CURRENCY_QUOTE" | jq -r ".rates.$CURRENCY_QUOTE")
quote=$(LANG=C printf "%.2f" "$quote")


echo "# $quote"
