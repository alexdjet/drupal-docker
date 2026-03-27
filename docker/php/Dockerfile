FROM php:8.3-fpm-alpine
RUN apk add --no-cache --virtual .build-deps \
    $PHPIZE_DEPS libpng-dev libjpeg-turbo-dev freetype-dev \
    libzip-dev icu-dev \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install -j1 gd zip pdo_mysql intl opcache \
  && apk del .build-deps \
  && rm -rf /tmp/*

RUN pecl install memcached && docker-php-ext-enable memcached

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN composer global require drush/drush && \
    ln -s /root/.composer/vendor/bin/drush /usr/local/bin/drush

RUN chown -R www-data:www-data /var/www/html

WORKDIR /var/www/html

