FROM php:5.6-apache
MAINTAINER solocommand

RUN apt-get update && apt-get install -y git \
  zip

# mcrypt
# RUN apk --update add libmcypt
# RUN docker-php-ext-install mcrypt # Errors?

# soap
# RUN apk --update add libxml2
# RUN docker-php-ext-install soap   # Errors?

# imagick
# RUN apk --update add imagemagick-dev imagemagick php5-imagick
# RUN yes "" | pecl install imagick


RUN apt-get update \
  && apt-get install -y libssl-dev

RUN yes "" | pecl install mongo-1.6.12 \
  && docker-php-ext-enable mongo

RUN yes "" | pecl install redis-2.2.5 \
  && docker-php-ext-enable redis

RUN yes "" | pecl install igbinary-2.0.1 \
  && docker-php-ext-enable igbinary

RUN a2enmod rewrite

RUN docker-php-ext-install zip

COPY files/vhost.conf /etc/apache2/sites-available/000-default.conf
COPY files/php.ini /usr/local/etc/php/php.ini
# RUN echo "<?php phpinfo();" > /var/www/html/index.php
# COPY app /var/www/html
# RUN chown -R www-data:www-data var && chmod -R 0755 var
# ENV APP_ENV prod
