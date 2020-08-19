#!/bin/bash
set -e
set -x

if [ -z "$STATPING_HOST" ]
then
    export STATPING_HOST=$(echo "$APP_ID" | tr '_' '-').cleverapps.io
fi

cat <<EOF > $APP_HOME/config.yml
connection: postgres
host: $POSTGRESQL_ADDON_HOST
user: $POSTGRESQL_ADDON_USER
password: $POSTGRESQL_ADDON_PASSWORD
database: $POSTGRESQL_ADDON_DB
port: $POSTGRESQL_ADDON_PORT
api_secret: "$STATPING_API_SECRET"
language: en
send_reports: true
location: $APP_HOME
letsencrypt_enable: false
domain: $STATPING_HOST
EOF
echo "Host: $STATPING_HOST"
env
cd $APP_HOME
wget https://github.com/statping/statping/releases/download/v$STATPING_VERSION/statping-linux-amd64.tar.gz
tar xvzf statping-linux-amd64.tar.gz
./statping env
./statping
