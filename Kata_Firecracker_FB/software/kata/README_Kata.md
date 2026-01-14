Clone the upstream

Upstream repo: https://github.com/kata-containers/kata-containers.git
Branch: main
Exact commit: d8405cb7f

Then apply the patch, i.e. override the following files with the files in the path:

- Makefile
- tools/osbuilder/rootfs-builder/ubuntu/Dockerfile.in
- tools/osbuilder/rootfs-builder/ubuntu/config.sh
