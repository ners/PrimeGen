all: build

build:
	stack build

exec: build
	stack exec -- PrimeGen-exe


IMAGE_NAME := primegen
image: build
	podman build \
		-t ${IMAGE_NAME} \
		.

CONTAINER_NAME := primegen
NEED_IMAGE = $(shell podman image exists ${IMAGE_NAME} || echo image)
container: ${NEED_IMAGE}
	podman run \
		--name ${CONTAINER_NAME} \
		--rm \
		--detach \
		-p 3000:3000 \
		${IMAGE_NAME}

NEED_CONTAINER = $(shell podman container start ${CONTAINER_NAME} || echo container)
shell: ${NEED_CONTAINER}
	podman exec -it ${CONTAINER_NAME} bash -i

.PHONY: all build exec image container
