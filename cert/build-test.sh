#!/bin/sh

DOMAIN=$1
EMAIL=$2

./build.sh $DOMAIN $EMAIL --test-cert
