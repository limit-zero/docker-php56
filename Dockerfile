FROM php:5.6-alpine
MAINTAINER solocommand

RUN apk --update add apache2 php5-apache2 $PHPIZE_DEPS openssl-dev php5-pear

# mcrypt
# RUN apk --update add libmcypt
# RUN docker-php-ext-install mcrypt # Errors?

# soap
# RUN apk --update add libxml2
# RUN docker-php-ext-install soap   # Errors?

# imagick
# RUN apk --update add imagemagick-dev imagemagick php5-imagick
# RUN yes "" | pecl install imagick

RUN yes "" | pecl install mongo-1.6.12 redis-2.2.5 igbinary
RUN docker-php-ext-install opcache mysqli zip
RUN docker-php-ext-enable mongo redis igbinary opcache mysqli zip

RUN sed -i "s#/app/#/app/$WEBAPP_ROOT#" /etc/apache2/httpd.conf

COPY files/httpd.conf /etc/apache2/httpd.conf
COPY files/php.ini /usr/local/etc/php/php.ini

RUN mkdir /run/apache2
RUN ln -sfT /dev/stderr /var/www/logs/error.log && ln -sfT /dev/stdout /var/www/logs/access.log

RUN echo "*/app/logs/*\n*/var/logs/*" > /etc/opcache.blacklist

ENV PHP_INI_SCAN_DIR /usr/local/etc/php/conf.d

WORKDIR /app
EXPOSE 80
CMD ["httpd", "-DFOREGROUND"]

# COPY files/test.php /app/test.php
# COPY files/status.conf /etc/apache2/conf.d/status.conf
