#!/bin/bash

# Check if all arguments are provided
if [ $# -lt 3 ]; then
  echo "Usage: $0 <input_file> <durations_file> <latencies_file>"
  exit 1
fi

# Input arguments
input_file=$1
durations_file=$2
latencies_file=$3

# Extract durations
grep -oP "'duration_ns': \K\d+" "$input_file" > "$durations_file"

# Extract client-perceived latencies
grep -oP "Client-perceived latency: \K\d+" "$input_file" > "$latencies_file"

# Calculate and append average for durations
duration_avg=$(awk '{sum+=$1} END {if (NR > 0) print sum/NR}' "$durations_file")
echo "Average duration_ns: $duration_avg" >> "$durations_file"

# Calculate and append average for latencies
latency_avg=$(awk '{sum+=$1} END {if (NR > 0) print sum/NR}' "$latencies_file")
echo "Average Client-perceived latency: $latency_avg" >> "$latencies_file"

# Confirm output files
echo "Durations saved to $durations_file (with average appended)"
echo "Client-perceived latencies saved to $latencies_file (with average appended)"

