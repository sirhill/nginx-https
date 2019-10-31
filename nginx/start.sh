#!/bin/bash

echo -e "================  VARIABLES  ===================
      DOMAIN=${DOMAIN:="www.domain.com"}"
echo "================================================="

if [[ -f "/etc/letsencrypt/live/$DOMAIN/fullchain.pem" &&
      -f "/etc/letsencrypt/certs/dhparam.pem" &&
      -f "/etc/letsencrypt/live/$DOMAIN/fullchain.pem" ]]; then
  sed -e "s|\$DOMAIN|${DOMAIN}|" /root/site-ssl.conf > /etc/nginx/conf.d/default.conf
else
  sed -e "s|\$DOMAIN|${DOMAIN}|" /root/default.conf > /etc/nginx/conf.d/default.conf
fi

nginx -g "daemon off;"

