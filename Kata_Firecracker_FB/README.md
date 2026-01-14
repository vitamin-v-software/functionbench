
Written by [dchar](https://github.com/DimitrisCharisis), edited by [filiadis](https://github.com/arkountos)

# Building Kata Containers with Firecracker on RISC-V

This document describes how to build and run Kata Containers with the Firecracker hypervisor on RISC-V, using **containerd + crictl** as the container runtime interface.

The setup was tested on QEMU emulating a RISC-V host, running Ubuntu 24.04.1 LTS.

> **NOTE**  
> This guide covers **only** the `crictl + containerd + kata + firecracker` execution path.  
> Kata Containers supports additional hypervisors and invocation tools (e.g., `nerdctl`, `ctr`, Kubernetes), but these setups are **out of scope**.  
> Most steps can be adapted to other configurations.

## Overview

In summary, this guide walks through:

- Building Kata Containers components manually  
- Building the Kata guest VM root filesystem via `osbuilder`
- Building the `crictl` CLI tool
- Connecting all components together
- Running the first-time setup
- Handling the "after first-time" setup
## Build Kata Containers

This can also be used as a reference documentation:

[https://github.com/kata-containers/kata-containers/blob/main/docs/how-to/how-to-use-kata-containers-with-firecracker.md](https://github.com/kata-containers/kata-containers/blob/main/docs/how-to/how-to-use-kata-containers-with-firecracker.md)

## Configure the Device Mapper Snapshotter

Firecracker passes the container image to the microVM as a block device. To do
this, containerd must use the devmapper snapshotter to create a block device for
the container image, which is then passed to Kata, and subsequently to the VM
agent, which mounts it inside the microVM.

In case there is no `ctr` tool installed, install `containerd` since `ctr`
comes with it. Containerd is officially supported in Ubuntu RISCV.

Check devmapper plugin status:

`sudo ctr plugins ls | grep devmapper`

Expected (initially):

`io.containerd.snapshotter.v1 devmapper linux/riscv64 skip`

The status **must become ok**.

Create a file `create.sh` (this script is provided in the repo):

```
#!/bin/bash
set -ex

DATA_DIR=/var/lib/containerd/devmapper
POOL_NAME=devpool

mkdir -p ${DATA_DIR}

# Create data file
sudo touch "${DATA_DIR}/data"
sudo truncate -s 100G "${DATA_DIR}/data"

# Create metadata file
sudo touch "${DATA_DIR}/meta"
sudo truncate -s 10G "${DATA_DIR}/meta"

# Allocate loop devices
DATA_DEV=$(sudo losetup --find --show "${DATA_DIR}/data")
META_DEV=$(sudo losetup --find --show "${DATA_DIR}/meta")

# Define thin-pool parameters.
# See https://www.kernel.org/doc/Documentation/device-mapper/thin-provisioning.txt for details.
SECTOR_SIZE=512
DATA_SIZE="$(sudo blockdev --getsize64 -q ${DATA_DEV})"
LENGTH_IN_SECTORS=$(bc <<< "${DATA_SIZE}/${SECTOR_SIZE}")
DATA_BLOCK_SIZE=128
LOW_WATER_MARK=32768

# Create a thin-pool device
sudo dmsetup create "${POOL_NAME}" \
    --table "0 ${LENGTH_IN_SECTORS} thin-pool ${META_DEV} ${DATA_DEV} ${DATA_BLOCK_SIZE} ${LOW_WATER_MARK}"
```

Run once:

`sudo bash create.sh`

Edit `/etc/containerd/config.toml` (temporary):
```
[plugins]
  [plugins.devmapper]
    pool_name = devpool
    root_path = /var/lib/containerd/devmapper
    base_image_size = "10GB"
    discard_blocks = true
```

Restart containerd, and test that the device mapper snapshotter works:

```
sudo systemctl restart containerd 
sudo dmsetup ls 
sudo ctr plugins ls | grep devmapper`
```

You should now see:

`io.containerd.snapshotter.v1 devmapper linux/riscv64 ok`

## Setup CNI Networking

Containerd requires CNI plugins for networking.

```
git clone https://github.com/containernetworking/plugins.git && cd plugins 
./build_linux.sh
sudo mkdir -p /opt/cni/bin
sudo cp -r bin/* /opt/cni/bin/
```

Create `/etc/cni/net.d/10-mynet.conf` (file also provided in repo):

```
{
        "cniVersion": "0.2.0",
        "name": "mynet",
        "type": "bridge",
        "bridge": "cni0",
        "isGateway": true,
        "ipMasq": true,
        "ipam": {
                "type": "host-local",
                "subnet": "172.19.0.0/24",
                "routes": [
                        { "dst": "0.0.0.0/0" }
                ]
        }
}
```

## Build Kata Components

### Prerequisites

`sudo apt install -y protobuf-compiler libprotobuf-dev`

### Clone and prepare Kata

```
```git clone https://github.com/kata-containers/kata-containers.git 
cd kata-containers
git checkout d8405cb7f`
```

Use the Makefile provided in the **patch**. The Makefile has essentially commented out these:

```
    - `COMPONENTS += dragonball`
    - `COMPONENTS += runtime-rs`
    - all `TOOLS += ...`
```

These components are unnecessary and problematic on RISC-V.

### Build

Kata comes with two runtimes, one written in Go and one in Rust. We
use the default one which is the Go version.

Run `make all`

This should build some libraries, and the important to us binaries `kata-agent`
(under `./src/agent/target/riscv64gc-unknown-linux-gnu/release/kata-agent`) and
`containerd-shim-kata-v2` (under `./src/runtime/`). It also builds the
`kata-runtime` binary.

Important artifacts:

1. `kata-agent`  
    `src/agent/target/riscv64gc-unknown-linux-gnu/release/kata-agent`
    
2. `kata-runtime`  
    `src/runtime/kata-runtime`
    
3. `containerd-shim-kata-v2`  
    `src/runtime/containerd-shim-kata-v2`
    
Install required binaries (copy to path):

```
sudo cp src/runtime/containerd-shim-kata-v2 /usr/local/bin/ 
sudo cp src/runtime/kata-runtime /usr/local/bin/
(sudo cp src/runtime/kata-runtime /usr/local/bin)
```

## Build Kata Guest RootFS

Copy the files from the provided patch (`Dockerfile.in` and `config.sh`). Now we can use the `osbuilder` tool on RISC-V

### Build rootfs image

From `tools/osbuilder`:

`make USE_DOCKER=true SECCOMP=no DISTRO=ubuntu OS_VERSION=jammy rootfs``

After building the rootfs, this creates a directory `ubuntu_rootfs` with the
contents of the rootfs inside (`/bin`, `/etc` etc). But we actually want to
extract the image file from this rootfs, in order to pass it as the VM rootfs.

Since the following command fails

`make USE_DOCKER=true SECCOMP=no DISTRO=ubuntu OS_VERSION=jammy image`

Because it uses a fedora image that is not supported for riscv64, run it without `USE_DOCKER=...` like:

`sudo make SECCOMP=no DISTRO=ubuntu OS_VERSION=jammy image`

This creates the VM rootfs file named `kata-image.img`.

## Kernel for the Guest VM

Use Linux **v6.13**:

- Commit: `ffd294d346d185b70e28b1a28abe367bbfe53c04`
- Use the provided `kernel-config` as the `.config`

This is the kernel that we also use for the QEMU RISCV "host". We encourage using the same because we have manually set some specific configuration options that were required for networking. 

Build and install:

```
sudo make modules_install
sudo make install 
sudo update-grub
```

Reboot the QEMU host into the new kernel.

## Install crictl

`git clone https://github.com/kubernetes-sigs/cri-tools.git cd cri-tools make`

Binary path:

`build/bin/linux/riscv64/crictl`

Create `/etc/crictl.yaml`:

`runtime-endpoint: unix:///var/run/containerd/containerd.sock image-endpoint: unix:///var/run/containerd/containerd.sock timeout: 4000 debug: true`

## Run a Test Container

Pull an image:

`sudo crictl pull docker.io/library/busybox:latest`

Create `sandbox\_config.json` and `container.json` (see `configurations/`).

Run:

```
sudo crictl runp -r kata sandbox_config.json 
sudo crictl create <POD_ID> container.json sandbox_config.json 
sudo crictl start <CONTAINER_ID> 
sudo crictl exec -it <CONTAINER_ID> bash
```

> **Note:**
> When running `sudo crictl runp`, in case you've already started a POD with this name you have to remove it
> first:
> ```
> $ sudo crictl pods
> => Get the POD ID
> $ sudo crictl stopp <POD_ID>
> $ sudo crictl rmp <POD_ID>
> ```

> **Note:**
> To check that the PODs are actually created, use
> `sudo crictl pods`
> This should show the name and ID of the created pod.

An example sandbox_config.json file is:

```
{
	"metadata": {
		"name": "busybox-pod",
		"uid": "busybox-pod",
		"namespace": "test.kata"
	},
	"hostname": "busybox_host",
	"log_directory": "",
	"dns_config": {
	},
	"port_mappings": [],
	"resources": {
	},
	"labels": {
	},
	"annotations": {
	},
	"linux": {
	}
}
```

An example `container.json` file is:

```
{
  "metadata": {
    "name": "busybox-pod"
  },
  "image": {
    "image": "docker.io/library/ubuntu:latest"
  },
  "command": [
    "bash"
  ],
  "log_path": "kata-container.log",
  "linux": {
    "security_context": {
      "privileged": false,
      "capabilities": {
        "add_capabilities": [
          "SYS_TIME"
        ]
      }
    }
  }
}
```

> **NOTE:**
> SYS_TIME capability is required in order to be able to set manually the time
> from the container inside the microVM.

You can use the above example files for this test.

Inside the container:

`echo "nameserver 8.8.8.8" > /etc/resolv.conf date -s "<current time>"`

Enable networking on host:

`sudo echo 1 > /proc/sys/net/ipv4/ip_forward sudo iptables -P FORWARD ACCEPT`

## After Reboot

Run the provided `reboot_script.sh` after reboot.

Recreate the devmapper pool and restart containerd:

```
sudo bash create.sh 
sudo systemctl restart containerd
```

Verify:

`sudo ctr plugins ls | grep devmapper`

## Required Configuration Files

- `/etc/containerd/config.toml`
- `/etc/kata-containers/configuration-fc.toml`
- `/etc/cni/net.d/10-mynet.conf`
- `/etc/crictl.yaml`

Exact contents are provided under the repository’s `configurations/` directory. Make sure all these files are present.
