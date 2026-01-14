#!/bin/bash
set -euo pipefail

if [[ $# -lt 3 ]]; then
    echo "Usage: $0 <runs> <benchmark> <custom_name>"
    echo "Available benchmarks:"
    echo "  dd"
    echo "  float_operation"
    echo "  gzip"
    echo "  chameleon"
    echo "  bucket_download_upload"
    echo "  image_processing"
    echo "  json_dumps"
    echo "  linpack"
    echo "  matmul"
    echo "  model_training"
    echo "  pyaes"
    echo "  video_processing"
    echo "  ml_lr"
    exit 1
fi

RUNS=$1
BENCH=$2
CUSTOM_NAME=$3

run() {
    local sandbox=$1
    local slim=$2
    local name=$3

    ./run_benchmark_n_times.sh "$sandbox" "$slim" "$RUNS" "$name"
}

case "$BENCH" in
    dd)
        run dd/sandbox.json dd/slim.json "dd_$CUSTOM_NAME"
        ;;
    float_operation)
        run float_operation/float_operation_sandbox.json \
            float_operation/float_operation_slim.json \
            "float_operation_$CUSTOM_NAME"
        ;;
    gzip)
        run gzip/sandbox.json gzip/slim.json "gzip_compression_$CUSTOM_NAME"
        ;;
    chameleon)
        run chameleon/chameleon_sandbox.json chameleon/chameleon_slim.json \
            "chameleon_$CUSTOM_NAME"
        ;;
    bucket_download_upload)
        run bucket_download_upload/sandbox.json bucket_download_upload/slim.json \
            "bucket_download_upload_$CUSTOM_NAME"
        ;;
    image_processing)
        run image_processing/sandbox.json image_processing/slim.json \
            "image_processing_$CUSTOM_NAME"
        ;;
    json_dumps)
        run json_dumps/sandbox.json json_dumps/slim.json \
            "json_dumps_$CUSTOM_NAME"
        ;;
    linpack)
        run linpack/sandbox.json linpack/slim.json \
            "linpack_$CUSTOM_NAME"
        ;;
    matmul)
        run matmul/sandbox.json matmul/slim.json \
            "matmul_$CUSTOM_NAME"
        ;;
    model_training)
        run model_training/sandbox.json model_training/slim.json \
            "model_training_$CUSTOM_NAME"
        ;;
    pyaes)
        run pyaes/pyaes_sandbox.json pyaes/pyaes_slim.json \
            "pyaes_$CUSTOM_NAME"
        ;;
    ml_lr)
        run ml_lr/sandbox.json ml_lr/slim.json \
            "ml_lr_$CUSTOM_NAME"
        ;;
    video_processing)
        run video_processing/sandbox.json video_processing/slim.json \
            "video_processing_$CUSTOM_NAME"
        ;;
    *)
        echo "Unknown benchmark: $BENCH"
        exit 1
        ;;
esac

