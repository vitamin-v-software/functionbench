#!/bin/bash

# !! CHANGE THE PATH !! #
# If needed, also change the ports
# Runs the listeners for the following benchmarks at the respective port, using functions-framework:
# - linpack, 8080
# - chameleon, 8081
# - matmul, 8082
# - float_operatio, 8083
# - pyaes, 8084
# - image_processing, 8085
# - video_processing, 8086

# Global path pointing to where the cpu-memory, disk and network folders are
INPUT_PATH="/home/arkountos/cloud_software/FunctionBench"

cd "$INPUT_PATH/cpu-memory/linpack"
functions-framework --target=function_handler --port=8080 & 

cd "$INPUT_PATH/cpu-memory/chameleon"
functions-framework --target=function_handler --port=8081 &

cd "$INPUT_PATH/cpu-memory/matmul"
functions-framework --target=function_handler --port=8082 &

cd "$INPUT_PATH/cpu-memory/float_operation"
functions-framework --target=function_handler --port=8083 &

cd "$INPUT_PATH/cpu-memory/pyaes"
functions-framework --target=function_handler --port=8084 &

cd "$INPUT_PATH/cpu-memory/image_processing"
functions-framework --target=function_handler --port=8085 &

cd "$INPUT_PATH/cpu-memory/video_processing"
functions-framework --target=function_handler --port=8086 &

lsof -i :8080,8081,8082,8083,8084,8085,8086


