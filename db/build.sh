#!/bin/bash

# init required folder
mkdir /data
chown ubuntu:ubuntu /data

# To build named image:
docker build -t db:latest .
