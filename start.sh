#!/bin/bash

CURRENT_DIR=`pwd`
NAME=nginx-https
DOMAIN=www.domain.com
EMAIL=security@domain.com

echo $CURRENT_DIR

sudo docker run -d -p 80:80 -p 443:443 \
       -v /data/letsencrypt:/etc/letsencrypt \
       -h $NAME --name $NAME \
       -e DOMAIN=$DOMAIN -e EMAIL=$EMAIL \
       sirhill/nginx-https

