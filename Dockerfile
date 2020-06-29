FROM jarzamendia/alpine-3.10

ARG PHP_VERSION=7.3.14-r0

RUN apk add --no-cache tini nginx mysql-client curl \ 
            libssh2 libpng freetype libjpeg-turbo \
            libgcc libxml2 libstdc++ icu-libs libltdl \
            libmcrypt msmtp \
            \
            php7-apcu=5.1.17-r1 \
            php7=$PHP_VERSION \
            php7-common=$PHP_VERSION \
            php7-fpm=$PHP_VERSION \
            php7-json=$PHP_VERSION \
            php7-xml=$PHP_VERSION \
            php7-pdo=$PHP_VERSION \
            php7-phar=$PHP_VERSION \
            php7-openssl=$PHP_VERSION \
            php7-pdo_mysql=$PHP_VERSION \
            php7-mysqli=$PHP_VERSION \
            php7-gd=$PHP_VERSION \
            php7-curl=$PHP_VERSION \
            php7-opcache=$PHP_VERSION \
            php7-ctype=$PHP_VERSION \
            php7-intl=$PHP_VERSION \
            php7-bcmath=$PHP_VERSION \
            php7-dom=$PHP_VERSION \
            php7-xmlreader=$PHP_VERSION \
            php7-pear=$PHP_VERSION \
            php7-mysqlnd=$PHP_VERSION \
            php7-mbstring=$PHP_VERSION \
            php7-fileinfo=$PHP_VERSION \
            php7-session=$PHP_VERSION \
            php7-ldap=$PHP_VERSION \
            php7-iconv=$PHP_VERSION \
            php7-zip=$PHP_VERSION \
            \
            && ln -sf /dev/stdout /var/log/php-fpm.log;

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/php-fpm.conf /etc/php/
COPY conf/php.ini /etc/php/
COPY run.sh /run.sh

VOLUME [ "/srv/www" ]

EXPOSE 80

ENV MAX_PHP_PROCESS="30"
ENV NGINX_PROCESS="2"

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["/bin/sh", "/run.sh"]