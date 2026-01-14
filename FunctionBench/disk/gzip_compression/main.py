from time import time
import os
import gzip


def function_handler(request):
    request_json = request.get_json(silent=True)
    file_size = request_json['file_size']
    file_write_path = '/home/ubuntu/serverless-faas-workbench/google/disk/gzip_compression/file'

    start = time()
    with open(file_write_path, 'wb') as f:
        f.write(os.urandom(file_size * 1024 * 1024))
    disk_latency = time() - start

    with open(file_write_path, 'rb') as f:
        start = time()
        with gzip.open('/home/ubuntu/serverless-faas-workbench/google/disk/gzip_compression/result.gz', 'wb') as gz:
            gz.writelines(f)
        compress_latency = time() - start

    print(compress_latency)
    return "disk latency : " + str(disk_latency) \
           + "/ compress latency : " + str(compress_latency)

