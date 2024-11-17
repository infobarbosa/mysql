#!/bin/bash

# Variables
IMAGE_NAME="infobarbosa/mysql"
TAG="8.0"

# Push the Docker image to Docker Hub
docker push $IMAGE_NAME:$TAG
docker push $IMAGE_NAME:latest

echo "Docker image $IMAGE_NAME:$TAG has been pushed to Docker Hub."