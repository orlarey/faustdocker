FAUSTGH="ghcr.io/orlarey/faustdocker"

# Build for local architecture only
image:
	docker build -t $(FAUSTGH):main .

# Build multi-architecture image (amd64, arm64)
# Requires QEMU: sudo apt-get install qemu-user-static
# Then run: docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
image-multi:
	@echo "Building multi-architecture image (amd64, arm64)..."
	@echo "Note: This requires QEMU for cross-compilation"
	docker buildx build --platform linux/amd64,linux/arm64 -t $(FAUSTGH):main --push .

# Setup buildx builder (run once)
buildx-setup:
	docker buildx create --name faustbuilder --use --bootstrap
	docker buildx inspect --bootstrap

# Push single architecture image
push:
	docker push $(FAUSTGH):main

test:
	docker run $(FAUSTGH):main

help:
	@echo " 'image'        : builds the docker image for local architecture"
	@echo " 'image-multi'  : builds and pushes multi-architecture image (amd64, arm64)"
	@echo " 'buildx-setup' : setup buildx builder for multi-architecture builds (run once)"
	@echo " 'test'         : run the docker image, equivalent to faust -v"
	@echo " 'push'         : push the docker image to docker repository"
 
 