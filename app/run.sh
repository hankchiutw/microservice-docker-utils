#!/bin/bash

APP_NAME=$1
APP_ENV=$2
APP=$APP_NAME-$APP_ENV
SSH_PORT=`cat ssh-port/$APP` # ex. 3122

# print container's public key
docker run --rm -it --name $APP $APP cat /etc/ssh/ssh_host_rsa_key.pub # or /root/.ssh/id_rsa.pub

# To run container as daemon:
docker run -itd --restart=always --name $APP -p 80:80 -p $SSH_PORT:22 $APP
docker ps -a
