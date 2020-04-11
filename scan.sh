#!/bin/bash

set -euo pipefail

MAX_TIMES=10
WAIT_SEC=5

AIRPORT=/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport
[ ! -f "$AIRPORT" ] && echo "Apple 'airport' not found" && exit 1

TEMP_FILE=/tmp/ssid-scan-$(date "+%Y%m%d_%H%M%S").txt
RESULT_FILE=ssid-scan-$(date "+%Y%m%d_%H%M").txt

echo "📶 scanner started"

BEST=0
CURRENT=0
for ((i = 1; i <= $MAX_TIMES; i++)); do
    "$AIRPORT" -s >"$TEMP_FILE"
    CURRENT=$(wc -l "$TEMP_FILE" | awk '{print $1}')
    if [ "$CURRENT" -eq 0 ]; then
        echo "  #${i} - ⏳ got blank result, wait for ${WAIT_SEC} sec"
        sleep $WAIT_SEC
        continue
    fi
    CURRENT=$((CURRENT - 1))
    if [ "$CURRENT" -gt "$BEST" ]; then
        BEST=$CURRENT
        mv "$TEMP_FILE" "$RESULT_FILE"
        echo "  #${i} - ✅ got ${CURRENT}, best result for now"
    else
        echo "  #${i} - 🔄 got ${CURRENT}, not good enough"
    fi
done

echo "📶 scanner ended"
