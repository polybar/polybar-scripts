#! /bin/sh

START=8
CORES=6
END=$(( START+CORES ))
AVG=0

while [ "$END" -gt "$START" ]
do
	NUM=$(sensors | sed -n "$START"p | awk '{print $3}' | cut -b 2-3)
	AVG=$(( AVG + NUM ))
	START=$(( START + 1 ))
done

average=$(( AVG / CORES ))

echo "🌡️ $average°C"

