#!/bin/sh

DOMAIN=$1
EMAIL=$2

# create
echo creating...
/data/certbot-auto certonly --standalone --email $EMAIL -d $DOMAIN $3

# copy
echo copying...
mkdir -p /data/cert
cp /etc/letsencrypt/live/$DOMAIN/fullchain.pem /data/cert/
cp /etc/letsencrypt/live/$DOMAIN/privkey.pem /data/cert/

echo done.
