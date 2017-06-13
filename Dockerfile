FROM php:5.6-alpine
MAINTAINER solocommand

RUN apk --update add apache2
RUN apk add --no-cache $PHPIZE_DEPS openssl-dev php5-pear

RUN yes "" | pecl install mongo-1.6.12 redis-2.2.5 igbinary
RUN docker-php-ext-enable mongo redis igbinary

RUN sed -i 's/#LoadModule\ rewrite_module/LoadModule\ rewrite_module/' /etc/apache2/httpd.conf
RUN sed -i 's/#LoadModule\ deflate_module/LoadModule\ deflate_module/' /etc/apache2/httpd.conf
RUN sed -i 's/#LoadModule\ expires_module/LoadModule\ expires_module/' /etc/apache2/httpd.conf

RUN sed -i "s#^DocumentRoot \".*#DocumentRoot \"/app/$WEBAPP_ROOT\"#g" /etc/apache2/httpd.conf
RUN sed -i "s#/var/www/localhost/htdocs#/app/$WEBAPP_ROOT#" /etc/apache2/httpd.conf
RUN printf "\n<Directory \"/app/$WEBAPP_ROOT\">\n\tAllowOverride All\n</Directory>\n" >> /etc/apache2/httpd.conf

WORKDIR /app

EXPOSE 80
ENTRYPOINT ["httpd", "-DFOREGROUND"]
CMD ["-DFOREGROUND"]
