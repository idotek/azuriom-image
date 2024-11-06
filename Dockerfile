FROM php:8.3-fpm-alpine

RUN apk update && \
    apk add --no-cache \
        zip \
        curl \
        mariadb-client \
        nginx \
        openssl \
        unzip \
        gnupg \
        git \
        gettext \
        bash \
        nodejs \
        npm && \
    curl -sSL https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions \
        -o /usr/local/bin/install-php-extensions && \
    chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions opcache pdo_mysql bcmath mbstring pdo tokenizer xml xmlwriter curl zip sqlite3 gd mysqli pgsql && \
    rm -rf /var/cache/apk/*

RUN adduser -D -s /bin/bash appuser

COPY docker/sites-available /etc/nginx/sites-available
ADD ./docker/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh && \
    chmod -R 770 /usr/local/bin/entrypoint.sh && \
    chown -R www-data:www-data /usr/local/bin/entrypoint.sh

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /data/www
COPY ./docker/.env.temp /tmp
RUN mkdir /etc/nginx/ssl
EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
ENTRYPOINT ["entrypoint.sh"]
