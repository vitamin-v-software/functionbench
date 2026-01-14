#!/bin/bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Input: input_file_name
# Change directory to input file's directory
# This script takes as input a file with all the responses from a benchmark (warm or cold, doesn't care) and outputs two files with the durations and the latencies respectively. One response in the input file may look like this:
#
# <Response [200]>
# {'duration_ns': 166468389, 'output': "{'len(result)': 6733}"}
# Client-perceived latency: 2507461596 ns
# INPUT: {"payload": [123, 34, 110, 114, 111, 119, 34, 58, 32, 49, 48, 44, 32, 34, 110, 99, 111, 108, 34, 58, 32, 4# 9, 53, 125], "metadata_map": {"header-nrow": "10", "header-ncol": "15"}}
#
# The output is four files, one with all the durations and one with all the latencies. 
# On the bottom of the files is the average of all the above values.
# Additionally, two files including only the average are outputed, to be used to plot (_dur_avg.txt, and _lat_avg.txt).
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Check if all arguments are provided
if [ $# -lt 1 ]; then
  echo "Usage: $0 <input_file>"
  exit 1
fi

# Input arguments
input_file=$1
durations_file="${input_file}_dur.txt"
latencies_file="${input_file}_lat.txt"
duration_avg_file="${input_file}_dur_avg.txt"
latency_avg_file="${input_file}_lat_avg.txt"

# Extract durations
grep -oP "'duration_ns': \K\d+" "$input_file" > "$durations_file"

# Extract client-perceived latencies
grep -oP "Client-perceived latency: \K\d+" "$input_file" > "$latencies_file"

# Calculate and append average for durations
duration_avg=$(awk '{sum+=$1} END {if (NR > 0) print sum/NR}' "$durations_file")
duration_avg=$(printf "%.0f" "$duration_avg") # This line is to print in standard format (not e.g. 42e+09 scientific format)
echo "Average duration_ns: $duration_avg" >> "$durations_file"

# Calculate and append average for latencies
latency_avg=$(awk '{sum+=$1} END {if (NR > 0) print sum/NR}' "$latencies_file")
latency_avg=$(printf "%.0f" "$latency_avg")
echo "Average Client-perceived latency: $latency_avg" >> "$latencies_file"

# Also output 2 files with only the average value!
echo "$duration_avg" >> "$duration_avg_file"
echo "$latency_avg" >> "$latency_avg_file"

# Confirm output files
echo "Durations saved to $durations_file (with average appended)"
echo "Client-perceived latencies saved to $latencies_file (with average appended)"

