FROM alpine:3.7


ENV PHALCON_VERSION=3.3.1

RUN apk update

RUN apk add --no-cache mongodb-tools ca-certificates tzdata php5-cli php5-pdo php5-fpm php5-json php5-mcrypt php5-dev php5-ldap php5-pear php5-openssl

RUN ln -sf /usr/bin/php5 /usr/bin/php

RUN ln -sf /usr/share/zoneinfo/Australia/Brisbane /etc/localtime && \
    echo "Australia/Brisbane" > /etc/timezone

RUN apk add --no-cache autoconf g++ binutils make openssl-dev curl git re2c file

RUN sed -i "$ s|\-n||g" /usr/bin/pecl

RUN pecl install mongo
RUN echo "extension=mongo.so" | tee /etc/php5/conf.d/mongo.ini

# RUN pecl install phalcon

RUN apk add php5-dev


WORKDIR /usr/src/php/ext/
# Compile Phalcon
RUN set -xe && \
    curl -LO https://github.com/phalcon/cphalcon/archive/v${PHALCON_VERSION}.tar.gz

RUN ln -sf /usr/bin/php-config5 /usr/bin/php-config && ln -sf /usr/bin/phpize5 /usr/bin/phpize
# RUN find / | grep "php-config"
RUN tar xzf v${PHALCON_VERSION}.tar.gz && cd cphalcon-${PHALCON_VERSION}/build && sh install && \
    cd ../.. && rm -rf v${PHALCON_VERSION}.tar.gz cphalcon-${PHALCON_VERSION} 
# RUN echo "extension=pdo.so" > /etc/php5/conf.d/pdo.ini
RUN echo "extension=phalcon.so" > /etc/php5/conf.d/phalcon.ini
RUN addgroup www-data
RUN adduser -u 100 -D -G www-data www-data
RUN mkdir -p /var/www/html/
# RUN chown -R www-data:www-data /var/www/html
WORKDIR /var/www/html

RUN { \
        echo '[global]'; \
        echo 'include=/etc/php5/fpm.d/*.conf'; \
        echo 'user=www-data'; \
        echo 'group=www-data'; \
        echo 'pm = dynamic'; \
        echo 'pm.max_children = 5'; \
        echo 'pm.start_servers = 2'; \
        echo 'pm.min_spare_servers = 1'; \
        echo 'pm.max_spare_servers = 3'; \
    } | tee /etc/php5/php-fpm.conf;
RUN { \
		echo '[global]'; \
		echo 'daemonize = no'; \
        # echo 'include=/etc/php5/fpm.d/*.conf'; \
		echo 'error_log = /proc/self/fd/2'; \
    } | tee /etc/php5/fpm.d/docker.conf;
RUN { \
		echo '[www]'; \
		echo 'listen = 9000'; \
		echo 'catch_workers_output = yes'; \
		echo 'clear_env = no'; \
		echo 'access.log = /proc/self/fd/2'; \        
	} | tee /etc/php5/fpm.d/www.conf


EXPOSE 9000
CMD ["/usr/bin/php-fpm5"]
