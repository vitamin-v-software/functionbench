#!/bin/bash

set -e

POD_ID="$1"

if [ -z "$POD_ID" ]; then
    echo "Usage: $0 <POD_ID>"
    exit 1
fi

echo "Cleaning up pod: $POD_ID"

# 1. Get all containers in this pod
CONTAINERS=$(sudo crictl ps -a --pod $POD_ID -q)

if [ -n "$CONTAINERS" ]; then
    echo "Stopping containers..."
    for C in $CONTAINERS; do
        sudo crictl stop $C || true
    done

    echo "Removing containers..."
    for C in $CONTAINERS; do
        sudo crictl rm $C || true
    done
else
    echo "No containers found in pod."
fi

# 2. Stop pod
echo "Stopping pod..."
sudo crictl stopp $POD_ID || true

# 3. Remove pod
echo "Removing pod..."
sudo crictl rmp $POD_ID || true

echo "Cleanup complete."
