#!/bin/sh

set -x

cd ~

git clone $REPO repo
cd repo/build-context


podman login -u $PODMAN_USER -p $PODMAN_PASSWORD $PODMAN_REGISTRY
podman build -t $IMAGE_TAG .
podman push $IMAGE_TAG $PODMAN_REGISTRY/$PODMAN_USER/$IMAGE_TAG
