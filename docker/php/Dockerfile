FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev \
    libzip-dev libicu-dev libpq-dev libmemcached-dev \
    unzip git zlib1g-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip pdo pdo_mysql intl opcache

RUN pecl install memcached && docker-php-ext-enable memcached

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN composer global require drush/drush && \
    ln -s /root/.composer/vendor/bin/drush /usr/local/bin/drush

RUN chown -R www-data:www-data /var/www/html

WORKDIR /var/www/html

