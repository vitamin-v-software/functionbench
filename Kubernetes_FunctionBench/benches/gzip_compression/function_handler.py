import json
from time import time
import os
import gzip


def function_handler(function_input):
    #request_json = request.get_json(silent=True)
    payload = json.loads(bytes(function_input["payload"]).decode("utf-8"))
    #file_size = request_json['file_size']
    file_size = int(payload["file_size"])
    file_write_path = '/tmp/file'
    #file_write_path = str(payload["file_write_path"])

    start = time()
    with open(file_write_path, 'wb') as f:
        f.write(os.urandom(file_size * 1024 * 1024))
    disk_latency = time() - start

    with open(file_write_path, 'rb') as f:
        start = time()
        with gzip.open('/tmp/result.gz', 'wb') as gz:
            gz.writelines(f)
        compress_latency = time() - start

    print(compress_latency)
    latency = compress_latency + disk_latency
    return {"processing_ns": latency}

