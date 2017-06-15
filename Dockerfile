FROM php:5.6-alpine
MAINTAINER solocommand

RUN apk --update add \
  apache2 \
  php5-apache2 \
  $PHPIZE_DEPS \
  openssl-dev \
  php5-pear \
  curl-dev

# mcrypt
# RUN apk --update add libmcypt
# RUN docker-php-ext-install mcrypt # Errors?

# soap
# RUN apk --update add libxml2
# RUN docker-php-ext-install soap   # Errors?

# imagick
# RUN apk --update add imagemagick-dev imagemagick php5-imagick
# RUN yes "" | pecl install imagick

RUN yes "" | pecl install mongo-1.6.12 \
  && docker-php-ext-enable mongo

RUN yes "" | pecl install redis-2.2.5 \
  && docker-php-ext-enable redis

RUN yes "" | pecl install igbinary-2.0.1 \
  && docker-php-ext-enable igbinary

RUN docker-php-ext-install \
  opcache \
  mysqli \
  zip

RUN docker-php-ext-install \
  ctype \
  curl \
  json \
  mysqli \
  opcache \
  zip

COPY files/httpd.conf /etc/apache2/httpd.conf
COPY files/php.ini /usr/local/etc/php/php.ini
COPY files/apache2-foreground /usr/local/bin/
COPY files/opcache.blacklist /etc/opcache.blacklist

WORKDIR /app
EXPOSE 80

ENTRYPOINT 'apache2-foreground'
CMD 'apache2-foreground'

# ENV WEBAPP_ROOT web
# COPY files/test.php /app/test.php
# COPY files/status.conf /etc/apache2/conf.d/status.conf
