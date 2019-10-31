#!/bin/bash

CURRENT_DIR=`pwd`
NAME=nginx-https

echo $CURRENT_DIR

sudo docker run -d -p 80:80 -p 443:443 \
       -v /data/share/config/letsencrypt:/etc/letsencrypt \
       -h $NAME --name $NAME \
       sirhill/nginx-https

