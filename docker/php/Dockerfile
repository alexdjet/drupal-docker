#FROM php:8.3-fpm-alpine

FROM php:8.3-fpm-alpine3.23
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.23/main" > /etc/apk/repositories \
    && echo "http://dl-cdn.alpinelinux.org/alpine/v3.23/community" >> /etc/apk/repositories \
    && apk update


RUN apk add --no-cache \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    libzip-dev \
    icu-dev \
    libmemcached-dev \
    libressl-dev \
    zlib-dev \
    unzip \
    git \
    bash \
    mysql-client \
    $PHPIZE_DEPS

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd zip pdo pdo_mysql intl opcache

RUN pecl install memcached && docker-php-ext-enable memcached

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

#RUN composer global require drush/drush && ln -s /root/.composer/vendor/bin/drush /usr/local/bin/drush

WORKDIR /var/www/html


