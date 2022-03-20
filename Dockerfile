# Add nodejs v15.11.0 and npm v7.6.0
FROM node:15.11.0-alpine as node

# Set master image
FROM rajeshisnepali/gitlab-ci-initial

LABEL maintainer="Rajesh Chaudhary rajeshisnepali@gmail.com"

# Set working directory
WORKDIR /var/www

# Add and Enable PHP-PDO Extenstions
RUN docker-php-ext-install pdo_mysql zip exif gd

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=1.10.10

# Install hirak/prestissimo for parallel install
RUN composer global require hirak/prestissimo

# Remove Cache
RUN rm -rf /var/cache/apk/*

CMD ["php-fpm"]
