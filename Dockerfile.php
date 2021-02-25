FROM php:7.3-fpm-alpine

RUN apk add --no-cache build-base autoconf bash ssmtp libedit-dev ldb-dev libldap openldap-dev libxml2-dev php7-pecl-mongodb git rsyslog
RUN docker-php-ext-install opcache readline json ldap xml bcmath mbstring && \
    git clone --branch 3.4.x --depth=1 "https://github.com/phalcon/cphalcon.git" && \
    cd cphalcon/build && \
    ./install && \
    echo "extension=phalcon.so" > /usr/local/etc/php/conf.d/phalcon.ini && \
    sed -i 's/mailhub=mail/mailhub=postfix/g' '/etc/ssmtp/ssmtp.conf' && \
    sed -i 's/#FromLineOverride=YES/FromLineOverride=YES/g' '/etc/ssmtp/ssmtp.conf'

RUN mkdir -p /usr/share/nginx/html/

COPY ./passwork/ /usr/share/nginx/html/
