#!/bin/bash

echo -e "================  VARIABLES  ===================
      DOMAIN=${DOMAIN}
      EMAIL=${EMAIL}"
echo "================================================="

if [[ -z $DOMAIN ]]; then
  echo "DOMAIN is not defined. Exiting";
  exit 1;
fi

if [[ -z $EMAIL ]]; then
  echo "EMAIL is not defined. Exiting";
  exit 1;
fi

sed -e "s|\$DOMAIN|${DOMAIN}|" /root/sslIssuing.sh \
     | sed -e "s|\$EMAIL|${EMAIL}|" > /etc/periodic/monthly/sslIssuing.sh
chmod a+x /etc/periodic/monthly/sslIssuing.sh

if [[  -f "/etc/letsencrypt/live/$DOMAIN/fullchain.pem" &&
  -f "/etc/letsencrypt/certs/dhparam.pem" ]]; then
  sed -e "s|\$DOMAIN|${DOMAIN}|" /root/site-ssl.conf > /etc/nginx/conf.d/default.conf
  nginx -g "daemon off;"
else
  sed -e "s|\$DOMAIN|${DOMAIN}|" /root/default.conf > /etc/nginx/conf.d/default.conf
  echo "Please the first time run /etc/periodic/monthly/sslIssuing.sh manually"
  echo "And then restart your docker"

  nginx -g "daemon off;"
fi

