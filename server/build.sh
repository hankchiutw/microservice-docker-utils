#!/bin/bash

mkdir /data
chown ubuntu:ubuntu /data
cp -rvp ./data/* /data/

# To build a named image:
docker build -t proxy:latest .
