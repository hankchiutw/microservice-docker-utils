#!/bin/bash

APP_NAME=$1
APP_ENV=$2
APP=$APP_NAME-$APP_ENV

docker kill $APP
docker rm $APP
