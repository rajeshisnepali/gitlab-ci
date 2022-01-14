# Set master image
FROM php:7.4-alpine3.11

LABEL maintainer="Rajesh Chaudhary rajeshisnepali@gmail.com"

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN apk update && apk add --no-cache \
    alpine-sdk shadow curl \
    zip libzip-dev \
    libpng-dev

# Add and Enable PHP-PDO Extenstions
RUN docker-php-ext-install pdo_mysql zip exif gd

# Remove Cache
RUN rm -rf /var/cache/apk/*

CMD ["php-fpm"]