#!/bin/bash

# Green color escape code
GREEN='\033[0;32m'

# Reset color
NC='\033[0m' # No Color

# Checkmark symbol
CHECKMARK='\xE2\x9C\x94'


echo "Sending request to float_operation..."
output_float_operation=$(eval "curl -X POST http://127.0.0.1:8083/float_operation -H "Content-Type: application/json" -d '{"N": 1000}'")

if [[ $output_float_operation == *"latency :"* ]]; then
        echo -e "Float_operation: ${GREEN}${CHECKMARK}${NC} Success!"
else
        echo "Output did not contain the expected result."
fi
echo "Float_operation DONE"

echo "Sending request to linpack..."
output_linpack=$(eval "curl -X POST http://localhost:8080/linpack -H \"Content-Type: application/json\" -d '{\"N\": 10}'")

if [[ $output_linpack == *"latency :"* ]]; then
        echo -e "Linpack: ${GREEN}${CHECKMARK}${NC} Success!"
else
        echo "Output did not contain the expected result."
fi
echo "Linpack DONE"

echo "Sending request to chameleon..."
output_chameleon=$(eval  "curl -X POST -H \"Content-Type: application/json\" -d '{\"num_of_rows\": 10, \"num_of_cols\": 5}' http://127.0.0.1:8081/chameleon")

if [[ $output_chameleon == *"latency :"* ]]; then
        echo -e "Chameleon: ${GREEN}${CHECKMARK}${NC} Success!"
else
        echo "Output did not contain the expected result."
fi
echo "Chameleon DONE"

echo "Sending request to PyAES..."
output_pyaes=$(eval  "curl -X POST http://127.0.0.1:8084/pyaes -H \"Content-Type: application/json\" -d '{\"length_of_message\": 32, \"num_of_iterations\": 10}'")

if [[ $output_pyaes == *"latency :"* ]]; then
        echo -e "PyAES: ${GREEN}${CHECKMARK}${NC} Success!"
else
        echo "Output did not contain the expected result."
fi
echo "PyAES DONE"

echo "Sending request to matmul..."
output_matmul=$(eval  "curl -X POST http://127.0.0.1:8082/matmul -H \"Content-Type: application/json\" -d '{\"N\": 100}'")

if [[ $output_matmul == *"latency :"* ]]; then
        echo -e "Matmul: ${GREEN}${CHECKMARK}${NC} Success!"
else
        echo "Output did not contain the expected result."
fi
echo "Matmul DONE"
