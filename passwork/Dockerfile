FROM passwork.php
ARG GIT_USER
ARG GIT_PASSWORD
ARG GITREPO
RUN  git clone http://${GIT_USER}:${GIT_PASSWORD}@${GITREPO} .
COPY ./keys/* /var/www/html/app/keys/
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
RUN find /var/www/ -type d -print0 | xargs -0 -I {} chmod 755 "{}"
RUN find /var/www/ -type f -print0 | xargs -0 -I {} chmod 644 "{}"
RUN chown -R www-data:www-data /var/www/html/

ENV HTTP_SECRET "1234"
ENV HTTP_DOMAIN "http://localhost:9080/"
ENV LANG "en"
ENV LANG_DISABLE "On"
ENV HIDE_SOCIAL "On"
ENV CSRF "Off"
ENV BAN_TIME "180"
ENV BAN_COUNT "7"
ENV BAN_INTERVAL "60"
ENV MONGODB_CONNSTR "mongodb://mongodb:27017"
ENV MONGODB_DBNAME "pwbox"
ENV MONGODB_USECREDS "false"

ENV LDAP_ENABLE "off"
ENV LDAP_SERVER "localhost"
ENV LDAP_PORT "389"
ENV LDAP_MASK "uid=<login>,ou=users,dc=crowd"
ENV BACKUP_ENABLE_LOGIN "Off"


VOLUME ["/var/www/html"]
CMD ["/docker-entrypoint.sh"]