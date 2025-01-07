#!/bin/bash

if [ -z "$1" ]; then
  echo "Error: VERSION_TAG is required as the first argument."
  exit 1
fi

VERSION_TAG=$1

echo "Building Docker image for version ${VERSION_TAG}..."
docker build --build-arg VERSION_TAG=${VERSION_TAG} -t nktnet/s-pdf:${VERSION_TAG} -t nktnet/s-pdf:latest .
if [ $? -ne 0 ]; then
  echo "Error: Docker build failed."
  exit 1
fi

echo "Pushing Docker image with version ${VERSION_TAG}..."
docker push nktnet/s-pdf:${VERSION_TAG}
if [ $? -ne 0 ]; then
  echo "Error: Docker push failed for ${VERSION_TAG}."
  exit 1
fi

echo "Pushing Docker image with latest tag..."
docker push nktnet/s-pdf:latest
if [ $? -ne 0 ]; then
  echo "Error: Docker push failed for latest."
  exit 1
fi

echo "Docker image with version ${VERSION_TAG} and latest tag successfully pushed!"

