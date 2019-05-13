#!/usr/bin/env bash
#
# Run Docker Image Locally
#
# ./run_image.sh --image=ctodd_python_dev --version=latest
#

DOCKERFILE="."
IMAGE_NAME=${PWD##*/}
IMAGE_VERSION="$(cat VERSION)"
CONTAINER_NAME=""
EXPOSED_PORT="8009"

# Parse CLI Arguments
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        -N|-n|-name|-C|-c|--container)
        CONTAINER_NAME="$2"
        shift
        shift
        ;;
        --name=*|--container=*)
        CONTAINER_NAME="${1#*=}"
        shift
        ;;
        --port)
        EXPOSED_PORT="$2"
        shift
        shift
        ;;
        --port=*)
        EXPOSED_PORT="${1#*=}"
        shift
        ;;
        *)
        shift
        ;;
    esac
done

IMAGE="${IMAGE_NAME}:${IMAGE_VERSION}"

if [ -z "${CONTAINER_NAME}" ]
then
  CONTAINER_NAME="${IMAGE_NAME}"
fi

echo "$(date +%c): Running Container ${CONTAINER_NAME} of image ${IMAGE}"
docker run --rm --detach -p ${EXPOSED_PORT}:5000 --name=${CONTAINER_NAME} ${IMAGE}
