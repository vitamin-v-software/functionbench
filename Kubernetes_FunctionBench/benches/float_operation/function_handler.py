import json

import math
from time import time

#def float_operation(N):
#    start = time()
#    for i in range(0, N):
#        sin_i = math.sin(i)
#        cos_i = math.cos(i)
#        sqrt_i = math.sqrt(i)
#    latency = time() - start
#    return latency

def function_handler(function_input):
    payload = json.loads(bytes(function_input["payload"]).decode("utf-8"))
    N = int(payload["N"])
    #request_json = request.get_json(silent=True)
    #N = request_json['N']
    #latency = float_operation(N)
    
    start = time()
    for i in range(0, N):
        sin_i = math.sin(i)
        cos_i = math.cos(i)
        sqrt_i = math.sqrt(i)
    latency = time() - start
    print(latency)
    return {"processing_ns": latency}
