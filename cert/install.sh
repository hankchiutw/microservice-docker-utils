#!/bin/sh

wget https://dl.eff.org/certbot-auto -P /data/
chmod a+x /data/certbot-auto

# do install process
/data/certbot-auto
