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

CERT_CMD="certbot certonly --webroot --force-renewal --agree-tos --webroot-path /usr/share/nginx/html --domain $CERTBOT_DOMAINS"
eval $CERT_CMD

CRON_SCRIPT=/etc/periodic/weekly/cerbot-renew
echo $CERT_CMD > $CRON_SCRIPT
echo "/usr/sbin/nginx -s reload" >> $CRON_SCRIPT
chmod a+x $CRON_SCRIPT

