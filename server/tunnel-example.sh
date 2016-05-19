#!/bin/sh

# database tunnel
ssh -L :27017:localhost:27017 db -nNT &

# app tunnel
ssh -L :3122:localhost:3122 sample-app-test -nNT &
