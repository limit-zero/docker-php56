FROM limit0/php56:latest

RUN apt-get update && apt-get install -y libmagickwand-dev

RUN yes "" | pecl install imagick \
  && docker-php-ext-enable imagick
