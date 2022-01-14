# Set master image
FROM alpine:3.11

LABEL maintainer="Rajesh Chaudhary rajeshisnepali@gmail.com"

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN apk update && apk add --no-cache \
    bash \
    rsync \
    openssh \
    alpine-sdk shadow curl

# Remove Cache
RUN rm -rf /var/cache/apk/*

