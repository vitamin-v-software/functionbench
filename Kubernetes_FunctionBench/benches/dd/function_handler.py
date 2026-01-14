import json
from time import time
import os
import subprocess


def function_handler(function_input):
    #request_json = request.get_json(silent=True)
    payload = json.loads(bytes(function_input["payload"]).decode("utf-8"))
    bs = 'bs=' + str(int(payload["bs"]))
    #bs = 'bs='+request_json['bs']
    count = 'count=' + str(int(payload["count"]))
    #count = 'count='+request_json['count']
    print(bs)
    print(count)
    # FIV: Added timer here and in the end
    start = time()
    out_fd = open('/tmp/io_write_logs','w')
    a = subprocess.Popen(['dd', 'if=/dev/zero', 'of=/tmp/out', bs, count], stderr=out_fd)
    a.communicate()
    
    output = subprocess.check_output(['ls', '-alh', '/tmp/'])
    print(output)

    output = subprocess.check_output(['du', '-sh', '/tmp/'])
    print(output)
                               
    with open('/tmp/io_write_logs') as logs:
        result = str(logs.readlines()[2]).replace('\n', '')
        latency = time() - start
        print(result)
        print(latency)
        return {"processing_ns": latency}
