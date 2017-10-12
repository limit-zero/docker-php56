FROM php:5.6-apache
MAINTAINER solocommand

RUN apt-get update && apt-get install -y git \
  wget \
  zip \
  libmcrypt-dev \
  libssl-dev \
  libxml2-dev

RUN yes "" | pecl install mongo-1.6.12 \
  && docker-php-ext-enable mongo

RUN yes "" | pecl install redis-2.2.5 \
  && docker-php-ext-enable redis

RUN yes "" | pecl install igbinary-2.0.1 \
  && docker-php-ext-enable igbinary

RUN a2enmod rewrite

RUN docker-php-ext-install zip
RUN docker-php-ext-install mcrypt
RUN docker-php-ext-install soap

COPY files/vhost.conf /etc/apache2/sites-available/000-default.conf
COPY files/php.ini /usr/local/etc/php/php.ini
