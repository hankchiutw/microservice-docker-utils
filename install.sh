#!/bin/sh

## install latest docker on Ubuntu 14.04

apt-get update
apt-get install apt-transport-https ca-certificates -y

apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" >> /etc/apt/sources.list.d/docker.list

apt-get update
apt-get autoremove docker.io -y
apt-get install linux-image-extra-`uname -r` -y
apt-get install docker-engine -y

