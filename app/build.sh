#!/bin/bash

APP_NAME=$1
APP_ENV=$2
APP=$APP_NAME-$APP_ENV

# To build named image:
docker build --build-arg APP_NAME=$APP_NAME --build-arg APP_ENV=$APP_ENV -t $APP:latest -f Dockerfile-template .
