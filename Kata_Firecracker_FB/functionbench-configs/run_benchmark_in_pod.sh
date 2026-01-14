#!/bin/bash

start=$(date +%s)
POD_ID=$(sudo crictl runp -r kata $1)
CONTAINER_ID=$(sudo crictl create $POD_ID $2 $1)
sudo crictl start $CONTAINER_ID
end=$(date +%s)

echo "Time to setup and run: $((end - start))s."
