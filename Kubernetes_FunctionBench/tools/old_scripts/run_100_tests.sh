#!/bin/bash

i=1

while [ $i -le 100 ]
do
	echo "Test $i..."
	HOSTPORT='147.102.4.87:31436' ./quicktest_client.py gzip_compression >> results/gzip_compression/gzip_compression.txt

	((i++))
done

