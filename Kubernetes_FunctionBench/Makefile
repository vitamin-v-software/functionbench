DOCKER ?= docker

REGISTRY = ghcr.io
OWNER ?= arkountos
IMG_PREFIX := vitaminv
TAG ?= 0.1.1

### Proposed naming convention
# TAG: 0.0.X means its QEMU (qemu)
# TAG: 0.1.X means its Firecracker (fc)

BENCHES := $(wildcard benches/*)

.PHONY: all
all: benches

###############################################################################

.PHONY: benches $(BENCHES)
benches: $(BENCHES)
$(BENCHES):
	-ln server.py $(wildcard $</*.py) $@
	$(DOCKER) buildx build \
		--progress=plain \
		--no-cache \
		--pull \
		--platform linux/amd64 \
		--push \
		-f $@/Dockerfile \
		-t $(REGISTRY)/$(OWNER)/$(IMG_PREFIX)-$(shell basename $@):$(TAG) \
		$@

.PHONY: base-images
base-images:
	$(MAKE) -C vitaminv/alpine-fiv
	$(MAKE) -C vitaminv/alpine-base
	$(MAKE) -C vitaminv/alpine-flask

###############################################################################

.PHONY: clean clean-images distclean

clean:
	@$(RM) -v $(shell find benches -name 'server.py')

clean-images:
	-@for d in $(shell ls benches); do \
		$(DOCKER) rmi $(REGISTRY)/$(OWNER)/$(IMG_PREFIX)-$$d:$(TAG); \
	done

distclean: clean clean-images

