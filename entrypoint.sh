#!/bin/sh
cd /etc/nginx
rm nginx.conf
set -e
export NAMESERVER=`cat /etc/resolv.conf | grep "nameserver" | awk '{print $2}' | tr '\n' ' '`
envsubst '
$$NAMESERVER
' < /etc/nginx/nginx.template.conf > /etc/nginx/nginx.conf

crontab -l | { cat; echo "0 6 * * * /usr/bin/certbot renew"; } | crontab -
crond

nginx -t
nginx -g "daemon off;"
