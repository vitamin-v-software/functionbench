#
# ckatsak, Wed Mar 13 02:12:20 PM EET 2024
#
DOCKER ?= docker
IMG := vitaminv-alpine-fiv
TAG := 0.0.4

.PHONY: $(IMG) clean
$(IMG):
	# NOTE: Assuming `docker login` has already been called
	$(DOCKER) buildx build \
		--progress=plain \
		--no-cache \
		--pull \
		--platform linux/amd64 \
		--push \
		--build-arg VITAMIN_V_TAG=$(TAG) \
		--tag ghcr.io/arkountos/$(IMG):$(TAG) \
		.
clean:
	$(DOCKER) rmi ghcr.io/arkountos/$(IMG):$(TAG)

