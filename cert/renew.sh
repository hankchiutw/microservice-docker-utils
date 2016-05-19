#!/bin/sh

if ! /data/certbot-auto renew -nvv > /var/log/letsencrypt/renew.log 2>&1 ; then
    echo Automated renewal failed:
    cat /var/log/letsencrypt/renew.log
    exit 1
else
    cat /var/log/letsencrypt/renew.log
fi

echo done.
#service nginx restart 
