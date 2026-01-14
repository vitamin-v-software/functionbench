#!/bin/bash

i=1

while [ $i -le 100 ]
do
	echo "Test $i..."

	HOSTPORT='147.102.4.87:31436' ./updated_quicktest_client.py chameleon ubuntu-12 >> results/chameleon/chameleon_cold.txt
	HOSTPORT='147.102.4.87:31436' ./updated_quicktest_client.py dd ubuntu-23 >> results/dd/dd_cold.txt
	HOSTPORT='147.102.4.87:31436' ./updated_quicktest_client.py float_operation ubuntu-11 >> results/float_operation/float_operation_cold.txt
	HOSTPORT='147.102.4.87:31436' ./updated_quicktest_client.py image_processing 11 >> results/image_processing/image_processing_cold.txt
	HOSTPORT='147.102.4.87:31436' ./updated_quicktest_client.py video_processing 18 >> results/video_processing/video_processing_cold.txt
	HOSTPORT='147.102.4.87:31436' ./updated_quicktest_client.py linpack ubuntu-12 >> results/linpack/linpack_cold.txt
	HOSTPORT='147.102.4.87:31436' ./updated_quicktest_client.py lr_serving ubuntu-11 >> results/lr_serving/lr_serving_cold.txt
	HOSTPORT='147.102.4.87:31436' ./updated_quicktest_client.py lr_training ubuntu-11 >> results/lr_training/lr_training_cold.txt
	HOSTPORT='147.102.4.87:31436' ./updated_quicktest_client.py matmul ubuntu-11 >> results/matmul/matmul_cold.txt
	HOSTPORT='147.102.4.87:31436' ./updated_quicktest_client.py pyaes ubuntu-11 >> results/pyaes/pyaes_cold.txt
	HOSTPORT='147.102.4.87:31436' ./updated_quicktest_client.py gzip_compression ubuntu-26 >> results/gzip_compression/gzip_compression_cold.txt
	((i++))

	sleep 200

done

