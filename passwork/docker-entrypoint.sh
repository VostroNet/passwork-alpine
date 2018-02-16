#!/bin/sh

# COPY ./config.ini 
# ENV HTTP_SECRET
# ENV HTTP_DOMAIN http://localhost:9080/
# ENV EMAIL_NOREPLY noreply@passwork.me
# ENV LANG en

export HTTP_SECRET=${HTTP_SECRET:-1234}
export HTTP_DOMAIN=${HTTP_DOMAIN:-"http://localhost:9080/"}
export LANG=${LANG:-en}
export LANG_DISABLE=${LANG_DISABLE:-"On"}
export HIDE_SOCIAL=${HIDE_SOCIAL:-"On"}
export CSRF=${CSRF:-"Off"}
export BAN_TIME=${BAN_TIME:-"180"}
export BAN_COUNT=${BAN_COUNT:-"7"}
export BAN_INTERVAL=${BAN_INTERVAL:-"60"}
export MONGODB_CONNSTR=${MONGODB_CONNSTR:-"mongodb://mongodb:27017/"}
export MONGODB_DBNAME=${MONGODB_DBNAME:-"pwbox"}
export MONGODB_USECREDS=${MONGODB_USECREDS:-"false"}

export LDAP_ENABLE=${LDAP_ENABLE:-"off"}
export LDAP_SERVER=${LDAP_SERVER:-"localhost"}
export LDAP_PORT=${LDAP_PORT:-"389"}
export LDAP_MASK=${LDAP_MASK:-"uid=<login>,ou=users,dc=crowd"}
export BACKUP_ENABLE_LOGIN=${BACKUP_ENABLE_LOGIN:-"Off"}
echo "writing config"
cat <<EOF > /var/www/html/app/config/config.ini
[crypt]
secret=$HTTP_SECRET

[application]
domain=$HTTP_DOMAIN
noreplyEmail=$EMAIL_NOREPLY
lang=$LANG
disableLanguageChange=$LANG_DISABLE
hideSocialNetworks=$HIDE_SOCIAL
superAdminEmail=$SUPERADMIN_EMAIL
csrf=$CSRF

[ban]
time= $BAN_TIME 
count=$BAN_COUNT
interval=$BAN_INTERVAL

[mongo]
connectionString=$MONGODB_CONNSTR
dbname=$MONGODB_DBNAME
useCreds=$MONGODB_USECREDS
username=$MONGODB_USERNAME
password=$MONGODB_PASSWORD

[ldap]
enable=$LDAP_ENABLE
server=$LDAP_SERVER
port=$LDAP_PORT
mask="$LDAP_MASK"

[backup]
enableLogin=$BACKUP_ENABLE_LOGIN
EOF

# cat /var/www/html/app/config/config.ini
echo "running php5"
/usr/bin/php-fpm5