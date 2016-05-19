#!/bin/sh

## init swap
dd if=/dev/zero of=/data/swap bs=1M count=1024
mkswap /data/swap
swapon /data/swap
swapon -s

# edit /etc/fstab
echo "/data/swap  swap  swap  defaults  0  0" >> /etc/fstab
