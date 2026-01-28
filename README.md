# FunctionBench

Contains the FunctionBench benchmark suite workloads. 

- FunctionBench: Contains a version of the benchmarks created to run without needing cloud communication via the `functions-framework` Google tool
- Kubernetes_FunctionBench: Contains a version of the benchmarks created to run with Kubernetes and Knative.
- Kata_Fircracker_FB: Contains all software components needed to run Kata Containers and Firecracker on a RISC-V QEMU machine, and all the configurations needed to use the images of the FunctionBench benchmarks with the software stack.

## FunctionBench Images

On top of the provided source code inside `FunctionBench` and `Kubernetes_FunctionBench` above, we also provide dockerized versions of the images as `ghcr.io` packages associated with this repository (see the 'Packages' section inside this repository).
