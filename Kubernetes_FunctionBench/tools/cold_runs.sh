#!/bin/bash

i=1
# benchmark_names=("chameleon" "dd" "float_operation" "gzip_compression" "image_processing" "linpack" "lr_serving" "lr_training" "matmul" "pyaes" "video_processing")
benchmark_names=("video_processing")


for benchmark in "${benchmark_names[@]}"; do
	mkdir -p "/home/users/filiadis/kube_functionbench/vitaminv/tools/results/$benchmark"
	file_path="/home/users/filiadis/kube_functionbench/vitaminv/tools/results/$benchmark/$benchmark.cold.txt"
	if [ -e "$file_path" ]; then
	  echo "File $file_path exists."
	else
	  # Create and write to the file
	  echo "" > "$file_path"
	fi
done

	
for i in {1..1}; do
	for benchmark in "${benchmark_names[@]}"; do
		HOSTPORT='147.102.4.87:31436' ./updated_quicktest_client.py $benchmark ubuntu-fc-1 >> "/home/users/filiadis/kube_functionbench/vitaminv/tools/results/$benchmark/$benchmark.cold.txt"
		echo "i=$i, bench=$benchmark"
	done
	sleep 65
	((i++))
done


