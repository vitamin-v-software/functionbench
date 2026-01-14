DOCKER ?= docker
IMG := vitaminv-ubuntu-base
TAG := 0.0.2

.PHONY: $(IMG) clean
$(IMG):
	# NOTE: Assuming `docker login` has already been called
	$(DOCKER) buildx build \
		--progress=plain \
		--no-cache \
		--pull \
		--platform linux/amd64 \
		--push \
		--tag ghcr.io/arkountos/$(IMG):$(TAG) \
		.
clean:
	$(DOCKER) rmi ghcr.io/arkountos/$(IMG):$(TAG)

