#!/usr/bin/env bash
#
# Exec Into Image By Container or Image ID
#

CONTAINER_ID=""
IMAGE_NAME=${PWD##*/}
IMAGE_VERSION="$(cat VERSION)"

# Parse CLI Arguments
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        -C|-c|--container)
        CONTAINER_ID="$2"
        shift
        shift
        ;;
        --container=*)
        CONTAINER_ID="${1#*=}"
        shift
        ;;
        -I|-i|--image)
        IMAGE="$2"
        shift
        shift
        ;;
        --image=*)
        IMAGE="${1#*=}"
        shift
        ;;
        *)
        shift
        ;;
    esac
done

IMAGE="${IMAGE_NAME}:${IMAGE_VERSION}"

if [ -z "${CONTAINER_ID}" ]
then
  echo "$(date +%c): No Container Specified, Need to Fetch from Image (${IMAGE})"
  # CONTAINER_ID=$(docker ps | grep "${IMAGE}" | awk '{ print $1 }')
  CONTAINER_ID=$(docker ps -qf ancestor=${IMAGE})
fi

if [ -z "${CONTAINER_ID}" ]
then
  echo "$(date +%c): Could not find running container of Image (${IMAGE}), Exiting"
  exit 1
fi

echo "$(date +%c): Execing into Container ${CONTAINER_ID} of image ${IMAGE}"
docker exec -it ${CONTAINER_ID} /bin/bash
