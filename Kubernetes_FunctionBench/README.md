# Kubernetes FunctionBench (Vitamin-V)

This repository contains a **Kubernetes / Knative–compatible version of FunctionBench**, adapted and extended for the **Vitamin-V project**.

Each benchmark is packaged as a **containerized HTTP function** and deployed as a **Knative Service**, enabling evaluation of cold starts, warm starts, and runtime overhead across different execution environments.

---

## Repository Structure

```text
.
├── base-images/
├── benches/
├── tools/
├── Makefile
└── README.md

`base-images/`

Base container images used by the benchmarks.

- Ubuntu and Alpine variants
- Pre-installed runtime dependencies, used as the foundation for benchmark images

`benches/`

Individual FunctionBench benchmarks. Each directory corresponds to one benchmark (e.g., chameleon, linpack, image_processing) and contains:

- A Dockerfile
- Benchmark logic (function_handler.py)
- An HTTP wrapper (server.py)

All benchmarks expose a common endpoint, 
`POST /invoke`

`tools/`

Scripts and utilities for running experiments and processing results. Key files and directories:

- updated_quicktest_client.py: Client used to invoke deployed Knative services and measure end-to-end latency.
- cold_runs.sh / warm_runs.sh: Scripts for executing cold-start and warm-start experiments.
- generate_plot_input_files.sh: Converts raw benchmark results into plotting-ready input.
- results/, results_fc/, results_qemu/: Collected results for different execution backends.
- knative/: This is a very important directory. Knative service definitions and deployment helpers. It contains the yaml files that connect each benchmark deployment with its corresponding image in the remote repository. This needs to be checked before deploying, to ensure that the name of the image and of the repository are correct.

## Deploying Benchmarks with Knative

Benchmarks are deployed as **Knative Services** using the manifests located under
the `tools/knative/` directory.

Each manifest defines a Knative Service that runs **one benchmark container**
and exposes it via an HTTP endpoint. Knative handles request routing, scaling
(including scale-to-zero), and service discovery.

---

### Knative Manifests

The `tools/knative/` directory contains one or more Kubernetes YAML files,
typically following this pattern:

```
tools/knative/
├── chameleon.yaml
├── linpack.yaml
├── image_processing.yaml
└── ...
```

Each YAML file defines a Knative Service (kind: Service) for a specific
benchmark. The service name follows the convention:

`vitaminv-<benchmark-name>-<container-id>`

This naming scheme is required by the benchmark client, which constructs
the service URL dynamically.

### Deploy a Benchmark
To deploy a single benchmark:

```
cd tools/knative
kubectl apply -f <benchmark>.yaml
```

Example:

```
kubectl apply -f chameleon.yaml
```

### Verify Deployment
List deployed Knative services:

`kubectl get`

Example output:

NAME                          URL
vitaminv-chameleon-ubuntu-11  http://vitaminv-chameleon-ubuntu-11.default.147.102.4.87.sslip.io

The reported URL corresponds to the endpoint that the benchmark client invokes.

You can use the `updated_quicktest_client.py` script to automate much of this process.


#### NOTE

Updated quicktest_client.py script that takes also a container_id argument, used to match the URL of the service running in kubernetes. For example HOSTPORT='147.102.4.87:31436' ./1_run_cold_times.py float_operation ubuntu-11, because the URL is http://vitaminv-float-operation-ubuntu-11.default.147.102.4.87.sslip.io. Also see old_scripts/quicktest_client.py for the scripts documentation.
