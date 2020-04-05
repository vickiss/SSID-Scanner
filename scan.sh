#!/bin/bash

set -euxo pipefail

AIRPORT=/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport

[ ! -f "$AIRPORT" ] && echo "Apple 'airport' not found" && exit 1

echo "Yes"
"$AIRPORT" -s
