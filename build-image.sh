#!/bin/bash

# Define variables
IMAGE_NAME="infobarbosa/mysql"
IMAGE_TAG="8.0"

# Build the Docker image
docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest

echo "Docker image ${IMAGE_NAME}:${IMAGE_TAG} has been built."