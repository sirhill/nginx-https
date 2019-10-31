#!/bin/bash

echo -e "================  VARIABLES  ===================
      SSL_DOMAINS=${SSL_DOMAINS:="www.domain.com domain.com"}
      CERTS_DIR=${CERTS_DIR:="/etc/letsencrypt/certs/"}"
echo "================================================="

mkdir -p $CERTS_DIR
openssl dhparam -dsaparam -out $CERTS_DIR/dhparam.pem 4096

CERTBOT_DOMAINS=""
for domain in $SSL_DOMAINS
do
  CERTBOT_DOMAINS="${CERTBOT_DOMAINS} --domain $domain"
done
certbot certonly --webroot --agree-tos --webroot-path /usr/share/nginx/html $CERTBOT_DOMAINS

CRON_SCRIPT=/etc/periodic/weekly/cerbot-renew
echo "certbot renew" > $CRON_SCRIPT
chmod a+x $CRON_SCRIPT

