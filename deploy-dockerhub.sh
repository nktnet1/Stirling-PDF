#!/bin/bash

if [ -z "$1" ]; then
  echo "Error: VERSION_TAG is required as the first argument."
  echo "   e.g. $0 0.40.2"
  exit 1
fi

HUB="nktnet/s-pdf"
VERSION_TAG="$1-fat"
LATEST_TAG="latest-fat"

echo "Building Docker image for version ${VERSION_TAG}..."

docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --pull \
  --build-arg VERSION_TAG="${VERSION_TAG}" \
  -t "${HUB}:${VERSION_TAG}" \
  -t "${HUB}:${LATEST_TAG}" \
  --push \
  -f ./Dockerfile.fat .

if [ $? -ne 0 ]; then
  echo "Error: Docker build failed."
  exit 1
fi

echo "Docker image with version ${VERSION_TAG} and ${LATEST_TAG} tag successfully pushed!"
