# Add nodejs v15.11.0 and npm v7.6.0
FROM node:15.11.0-alpine as node

# FROM python:2.7.18-buster as python

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


# Install python2.7
RUN apk update && apk add --no-cache \
    python2

# Add and Enable PHP-PDO Extenstions
RUN docker-php-ext-install pdo_mysql zip exif gd

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=1.10.10

# Install hirak/prestissimo for parallel install
RUN composer global require hirak/prestissimo

# Install node15
COPY --from=node /usr/lib /usr/lib
COPY --from=node /usr/local/share /usr/local/share
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /usr/local/include /usr/local/include
COPY --from=node /usr/local/bin /usr/local/bin

# Install python2
# COPY --from=python /usr/lib /usr/lib
# COPY --from=python /usr/local/share /usr/local/share
# COPY --from=python /usr/local/lib /usr/local/lib
# COPY --from=python /usr/local/include /usr/local/include
# COPY --from=python /usr/local/bin /usr/local/bin

# Remove Cache
RUN rm -rf /var/cache/apk/*

CMD ["php-fpm"]
