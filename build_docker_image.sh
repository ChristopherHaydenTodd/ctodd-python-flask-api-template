#!/usr/bin/env bash
#
# Build and Tag Docker Image (Locally)
#
# Example: ./build_image.sh
#

DOCKERFILE="."
IMAGE_NAME=${PWD##*/}
IMAGE_VERSION="$(cat VERSION)"

IMAGE="${IMAGE_NAME}:${IMAGE_VERSION}"

echo "$(date +%c): Building and Tagging ${IMAGE} from Dockerfile ${DOCKERFILE}"
docker build --tag=${IMAGE} ${DOCKERFILE}
