# Set master image
FROM php:7.4-fpm-alpine

LABEL maintainer="Rajesh Chaudhary rajeshisnepali@gmail.com"

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN apk update && apk add --no-cache \
    bash \
    rsync \
    openssh \
    alpine-sdk shadow vim curl \
    zip libzip-dev \
    libpng-dev

# Add and Enable PHP-PDO Extenstions
RUN docker-php-ext-install pdo_mysql zip exif gd

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install hirak/prestissimo for parallel install
RUN composer global require hirak/prestissimo

# Add nodejs and npm
RUN apk add --update nodejs npm

# Remove Cache
RUN rm -rf /var/cache/apk/*

CMD ["php-fpm"]
