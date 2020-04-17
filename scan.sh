#!/bin/bash

set -euo pipefail

WAIT_SEC=5
MAX_TIMES=10
if [ "$#" -ge 1 ]; then
    MAX_TIMES=$1
fi

if ! [ "$MAX_TIMES" -gt 0 ] 2>/dev/null; then
    echo "❗ max_times should be >= 1"
    exit 1
fi

AIRPORT=/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport
[ ! -f "$AIRPORT" ] && echo "Apple 'airport' not found" && exit 1

RESULT_FILE=ssid-scan-$(date "+%Y%m%d_%H%M%S").txt
TEMP_FILE=/tmp/"$RESULT_FILE"

echo "📶 scanner started"

BEST=0
CURRENT=0
for ((i = 1; i <= $MAX_TIMES; i++)); do
    "$AIRPORT" -s >"$TEMP_FILE"
    CURRENT=$(wc -l "$TEMP_FILE" | awk '{print $1}')
    if [ "$CURRENT" -eq 0 ]; then
        printf "  %3s - ⏳ got blank result, wait for ${WAIT_SEC} sec\n" "#${i}"
        sleep $WAIT_SEC
        continue
    fi
    CURRENT=$((CURRENT - 1))
    if [ "$CURRENT" -gt "$BEST" ]; then
        BEST=$CURRENT
        mv "$TEMP_FILE" "$RESULT_FILE"
        printf "  %3s - ☑️  got ${CURRENT}, best result for now\n" "#${i}"
    else
        printf "  %3s - 🔄 got ${CURRENT}, not good enough\n" "#${i}"
    fi
done

echo "📶 scanner ended"
