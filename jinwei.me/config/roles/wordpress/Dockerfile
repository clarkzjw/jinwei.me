FROM wordpress:apache

RUN apt-get update -y && apt-get install -y libgmp-dev && docker-php-ext-install gmp

ADD uploads.ini /usr/local/etc/php/conf.d/uploads.ini
