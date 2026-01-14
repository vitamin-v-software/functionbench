#!/bin/bash

# Ensure the correct number of arguments
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <output_file> <directory>"
    exit 1
fi

# Arguments
output_file="$1"
search_directory="$2"

# Clear or create the output file
> "$output_file"

# Find and process files ending with "dur_avg.txt"
find "$search_directory" -type f -name "*dur_avg.txt" | while read -r file; do
    echo "Processing $file..."
    cat "$file" >> "$output_file"
done

echo "All matching files have been combined into $output_file."
