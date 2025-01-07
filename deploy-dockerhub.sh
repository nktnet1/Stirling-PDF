#!/bin/bash

if [ -z "$1" ]; then
  echo "Error: VERSION_TAG is required as the first argument."
  exit 1
fi

HUB="nktnet/s-pdf"
VERSION_TAG="$1-fat"
LATEST_TAG="latest-fat"

echo "Building Docker image for version ${VERSION_TAG}..."
docker build \
    --no-cache \
    --pull \
    --build-arg VERSION_TAG="${VERSION_TAG}" \
    -t "${HUB}:${VERSION_TAG}" \
    -t "${HUB}:${LATEST_TAG}" \
    -f ./Dockerfile.fat .

if [ $? -ne 0 ]; then
  echo "Error: Docker build failed."
  exit 1
fi

echo "Pushing Docker image with version ${VERSION_TAG}..."
docker push "${HUB}:${VERSION_TAG}"
if [ $? -ne 0 ]; then
  echo "Error: Docker push failed for ${VERSION_TAG}."
  exit 1
fi

echo "Pushing Docker image with ${LATEST_TAG} tag..."
docker push "${HUB}:${LATEST_TAG}"
if [ $? -ne 0 ]; then
  echo "Error: Docker push failed for ${LATEST_TAG}."
  exit 1
fi

echo "Docker image with version ${VERSION_TAG} and ${LATEST_TAG} tag successfully pushed!"
