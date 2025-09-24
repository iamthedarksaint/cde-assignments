#!/bin/bash

echo "Setting environment variables..."

# Exit the script immediately if any command fails
set -e

#Load environment vairables from .env file into my bash scrips
echo "Loading environment vairables..."
source .env

echo "Environment varibales Loaded!"


echo "Stopping conatainers..."
docker stop "$POSTGRES_CONTAINER_NAME" || true
docker stop "$ETL_CONTAINER_NAME" || true
echo "Containers Stopped!"

# docker stop "$ETL_CONTAINER_NAME"
echo "Removing Containers if exists..."
docker rm "$POSTGRES_CONTAINER_NAME" || true
docker rm "$ETL_CONTAINER_NAME" || true
echo "Conatiners Removed!"

echo "Removing Image if exists..."
docker rmi $ETL_IMAGE_NAME || true
echo "Image Removed!"

echo "Removing Network if exists..."
docker network rm "$NETWORK_NAME"
echo "network Removed!"

echo "Creating network..."
docker network create "$NETWORK_NAME"
echo "network Created!"

echo "Building ETL Image..."
docker build -f Dockerfile -t "$ETL_IMAGE_NAME" .
echo "Image finished building!"

echo "Starting Postgres container"
docker run -d -e POSTGRES_USER=$POSTGRES_USER -p 55432:5432 -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD -e POSTGRES_DB=$POSTGRES_DB --name $POSTGRES_CONTAINER_NAME --network $NETWORK_NAME postgres 

echo "Getting Postgres ready...."

sleep 40
echo "Running my ETL container..."
docker run -it --name "$ETL_CONTAINER_NAME" --network $NETWORK_NAME --env-file .env $ETL_IMAGE_NAME 