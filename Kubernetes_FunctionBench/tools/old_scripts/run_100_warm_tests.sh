#!/bin/bash

i=1
bench="$1"
echo "Input benchmark is: $bench"

mkdir -p "/home/users/filiadis/kube_functionbench/vitaminv/tools/results/$bench"

file_path="/home/users/filiadis/kube_functionbench/vitaminv/tools/results/$bench/$bench.txt"
if [ -e "$file_path" ]; then
  echo "File $file_path exists."
else
  # Create and write to the file
  echo "" > "$file_path"
fi

# This is a cold run, don't write its result in the file. Just get the pod running
HOSTPORT='147.102.4.87:31436' ./updated_quicktest_client.py $bench ubuntu-fc-1 # This is a cold run, don't write its result down.

while [ $i -le 10 ]
do
	echo "Test $i..."
	HOSTPORT='147.102.4.87:31436' ./updated_quicktest_client.py $bench ubuntu-fc-1 >> "$file_path.warm.txt" # These are the warm runs

	((i++))
done

