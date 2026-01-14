#!/bin/bash

# Usage: ./run_all.sh 3 run_name_1612-1355

CUSTOM_NAME=$2

 ./run_benchmark_n_times.sh dd/sandbox.json dd/slim.json $1 dd_$CUSTOM_NAME;
 ./run_benchmark_n_times.sh float_operation/float_operation_sandbox.json float_operation/float_operation_slim.json $1 float_operation_$CUSTOM_NAME; 
 ./run_benchmark_n_times.sh gzip/sandbox.json gzip/slim.json $1 gzip_compression_$CUSTOM_NAME; 
 ./run_benchmark_n_times.sh chameleon/chameleon_sandbox.json chameleon/chameleon_slim.json $1 chameleon_$CUSTOM_NAME;
 ./run_benchmark_n_times.sh bucket_download_upload/sandbox.json bucket_download_upload/slim.json $1 bucket_download_upload_$CUSTOM_NAME;
 ./run_benchmark_n_times.sh image_fake/sandbox.json image_fake/slim.json $1 image_fake_$CUSTOM_NAME;
 #./run_benchmark_n_times.sh json_dumps/sandbox.json json_dumps/slim.json $1 jsun_dumps_$CUSTOM_NAME;
 ./run_benchmark_n_times.sh linpack/sandbox.json linpack/slim.json $1 linpack_$CUSTOM_NAME;
 ./run_benchmark_n_times.sh matmul/sandbox.json matmul/slim.json $1 matmul_$CUSTOM_NAME;
 #./run_benchmark_n_times.sh model_training/sandbox.json model_training/slim.json $1 model_training_$CUSTOM_NAME;
 ./run_benchmark_n_times.sh pyaes/pyaes_sandbox.json pyaes/pyaes_slim.json $1 pyaes_$CUSTOM_NAME;
 ./run_benchmark_n_times.sh video_processing/sandbox.json video_processing/slim.json $1 video_processing_$CUSTOM_NAME;

