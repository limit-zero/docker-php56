FROM php:5.6-alpine
MAINTAINER solocommand

RUN apk --update add \
  apache2 \
  php5-apache2 \
  $PHPIZE_DEPS \
  openssl-dev \
  php5-pear

# mcrypt
# RUN apk --update add libmcypt
# RUN docker-php-ext-install mcrypt # Errors?

# soap
# RUN apk --update add libxml2
# RUN docker-php-ext-install soap   # Errors?

# imagick
# RUN apk --update add imagemagick-dev imagemagick php5-imagick
# RUN yes "" | pecl install imagick

RUN yes "" | pecl install \
  mongo-1.6.12 \
  redis-2.2.5 \
  igbinary

RUN docker-php-ext-install \
  opcache \
  mysqli \
  zip

RUN docker-php-ext-enable \
  mongo \
  redis \
  igbinary \
  opcache \
  mysqli \
  zip

COPY files/httpd.conf /etc/apache2/httpd.conf
COPY files/php.ini /usr/local/etc/php/php.ini
COPY files/apache2-foreground /usr/local/bin/

WORKDIR /app
EXPOSE 80

ENTRYPOINT 'apache2-foreground'
CMD 'apache2-foreground'

# ENV WEBAPP_ROOT web
# COPY files/test.php /app/test.php
# COPY files/status.conf /etc/apache2/conf.d/status.conf
