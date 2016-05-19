#!/bin/bash

# To run container as daemon:
docker run -itd --restart=always --name db -p 27017:27017 \
	-v /data/db:/data/db \
	-v /data/mongod.conf:/etc/mongod.conf \
	-v /var/log/mongodb:/var/log/mongodb \
	-v /var/log/td-agent:/var/log/td-agent \
	-v /data/td-agent/db.conf:/etc/td-agent/db.conf \
	db

docker ps -a

sleep 1
docker exec db ps -aux|grep 'mongod --config'
docker exec db /etc/init.d/td-agent status
