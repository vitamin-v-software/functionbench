#!/bin/bash
set -euo pipefail

# Usage: ./run_benchmark_n_times sandbox.json container.json 3 customNameForThisRun

POD_CONFIG=$1        # sandbox.json
CONTAINER_CONFIG=$2  # container.json
RUNS=${3:-10}        # default: 10 runs
CUSTOM_NAME=$4
OUTDIR=results/results_${CUSTOM_NAME}_$(date +%m%d_%H%M)

mkdir -p "$OUTDIR"

echo "run,setup_time,run_time,total_time,benchmark_output" > "$OUTDIR/results.csv"

for i in $(seq 1 "$RUNS"); do
	echo "$(date +%m%d_%H%M) ---=== Run $i / $RUNS ===---"

    # This is for minio to work
    sudo date --set "2025-12-12 13:37:00"
    # Start minio (using the above time). Close minio at the end of the loop
    #tmux new -d -s minio 'minio server /minio/data --console-address ":9001"'

    # Wait for minio to be ready before continuing!
    #until curl -sf http://127.0.0.1:9000/minio/health/ready; do
    #    sleep 1
    #done


    start=$(date +%s)

    POD_ID=$(sudo crictl runp -r kata "$POD_CONFIG")
    CONTAINER_ID=$(sudo crictl create "$POD_ID" "$CONTAINER_CONFIG" "$POD_CONFIG")
    setup_end=$(date +%s)

    sudo crictl start "$CONTAINER_ID"

    # Wait for container to finish
    # sudo crictl wait "$CONTAINER_ID" > /dev/null
    while true; do
    	state=$(sudo crictl inspect "$CONTAINER_ID" | jq -r '.status.state')
	[[ "$state" != "CONTAINER_RUNNING" ]] && break
	sleep 0.1
    done

    end=$(date +%s)
    setup_time=$((setup_end - start))
    run_time=$((end - setup_end))
    total_time=$((end - start))

    # Collect logs (benchmark output)
    output=$(sudo crictl logs "$CONTAINER_ID" 2>&1 | tr '\n' ' ' | sed 's/,/;/g')

    echo "$i,$setup_time,$run_time,$total_time,$output" >> "$OUTDIR/results.csv"

    # Cleanup
    sudo crictl rm "$CONTAINER_ID"
    sudo crictl stopp "$POD_ID"
    sudo crictl rmp "$POD_ID"

    # Kill previous minio server, we'll start one again next loop.
    #tmux kill-session -t minio

done

echo "All runs completed. Results in $OUTDIR/results.csv"




