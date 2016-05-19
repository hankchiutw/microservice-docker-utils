#!/bin/bash

# To run container as daemon:
docker run -itd --restart=always --name proxy -p 80:80 -p 443:443 \
	-v /data/ssl.conf:/etc/nginx/conf.d/default.conf \
	-v /data/cert:/etc/nginx/cert \
	-v /var/log/nginx:/var/log/nginx \
	-v /var/log/td-agent:/var/log/td-agent \
	-v /data/td-agent/proxy.conf:/etc/td-agent/proxy.conf \
	proxy

docker ps -a

sleep 1

docker exec proxy /etc/init.d/nginx status
docker exec proxy /etc/init.d/td-agent status
