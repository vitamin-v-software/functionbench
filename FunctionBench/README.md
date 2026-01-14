These FunctionBench benchmarks have been ported to RISC-V, and are meant to be run using Google's `functions_framework`

The benchmark Python codes are inside the three folders `cpu-memory`, `disk` and `network`.

Dependencies (for the helper scripts `listeners.sh` and `requests.sh`: 
- functions-framework
- lsof

Additional dependencies to run the suite can be installed with:
`sudo apt install jpeg libssl-dev gfortran libopenblas-dev`

A file named `requirements.txt` contains all the python packages that are needed for the benchmarks to run. It is recommeded that a python virtual environment be created, activated and then the packages installed there.

To create a virtual environment and prepare it for FunctionBench:

- Run `python3 -m venv <name_of_environment>`
- Run `source <name_of_environment>/bin/activate`
- Run `python3 -m pip install -r requirements.txt`

To run the tests:

- Source the correct python virtual environment 
- Update the paths in `listeners.sh`
- On one terminal run `listeners.sh`
- On another terminal run `requests.sh`
