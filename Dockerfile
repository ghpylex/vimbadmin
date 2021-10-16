# Container image that runs your code
FROM alpine:3.14

# env vars
ENV INSTALL_PATH=/srv/vimbadmin
ENV vimbadmin_version="3.2.1"

# install dependencies
RUN apk add --no-cache \
	php7-cli \
	php7-phar \
	php7-cgi \
	php7-memcached \
	php7-pdo_mysql \
	php7-tokenizer \
	php7-mbstring \
	php7-mcrypt \
	php7-gettext \
	php7-opcache \
	php7-json \
	php7-simplexml \
	php7-ctype \
	php7-iconv \
	php7-openssl \
	php7-apache2 \
	apache2 \
	dovecot \
	tzdata

# apache2 config
COPY vimbadmin.conf /etc/apache2/conf.d/vimbadmin.conf

# add composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# install vimbadmin via composer
RUN composer create-project --prefer-dist --no-dev opensolutions/vimbadmin:${vimbadmin_version} ${INSTALL_PATH}
RUN cp ${INSTALL_PATH}/application/configs/application.ini.dist ${INSTALL_PATH}/application/configs/application.ini
RUN cp ${INSTALL_PATH}/public/.htaccess.dist ${INSTALL_PATH}/public/.htaccess
RUN chown -R apache:apache ${INSTALL_PATH}

# remove composer
RUN rm -f /usr/local/bin/composer

# set timezone
ENV TZ="Europe/Berlin"

# Comand to execute when the docker container starts up
CMD ["/usr/sbin/httpd", "-DFOREGROUND"]
