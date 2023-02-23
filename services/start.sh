#!/bin/bash

# Stop all docker containers
docker stop $(docker ps --all -q) 

# Remove all docker containers
docker rm $(docker ps --all -q)

# Prepare the Python image using the Dockerfile
docker build -t python-main-image .

# Run the docker-compose file
docker-compose up -d