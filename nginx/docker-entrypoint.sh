#!/bin/sh

export UPSTREAM_HOST=${UPSTREAM_HOST:-"php-fpm"}
echo "writing upstream config"
cat <<EOF > /etc/nginx/conf.d/upstream.conf
upstream balance {
  least_conn;
  server $UPSTREAM_HOST:9000;
}
EOF

echo "running nginx"
nginx -g "daemon off;"