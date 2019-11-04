#!/bin/bash

echo -e "================  VARIABLES  ===================
  DOMAIN=$DOMAIN
  EMAIL=$EMAIL
  CERTS_DIR=${CERTS_DIR:="/etc/letsencrypt/certs/"}"
echo "================================================="

if [[ ! -d $CERTS_DIR || ! -f $CERTS_DIR/dhparam.pem ]]; then
  echo "Issuing new certificates for $DOMAIN"
  mkdir -p $CERTS_DIR
  openssl dhparam -dsaparam -out $CERTS_DIR/dhparam.pem 4096
else
  echo "Renewing certificates for $DOMAIN"
fi

certbot certonly -m $EMAIL --no-eff-email --webroot --force-renewal --agree-tos --webroot-path /usr/share/nginx/html --domain $DOMAIN
/usr/sbin/nginx -s reload
