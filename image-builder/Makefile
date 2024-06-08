all:
	podman build -t image-builder .
	podman push image-builder quay.io/vraiti/image-builder
test:
	podman run -it --env-file=envfile image-builder
