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
        postfix \
        npm && \
    curl -sSL https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions \
        -o /usr/local/bin/install-php-extensions && \
    chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions opcache pdo_mysql bcmath mbstring pdo tokenizer xml xmlwriter curl zip sqlite3 gd mysqli pgsql && \
    rm -rf /var/cache/apk/* && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY docker/sites-available /etc/nginx/sites-available 
COPY docker/nginx/nginx.conf    /etc/nginx/nginx.conf
ADD ./docker/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh && \
    chown -R www-data:www-data /usr/local/bin/entrypoint.sh

WORKDIR /data/www
COPY ./docker/.env.temp /tmp
RUN mkdir /etc/nginx/ssl /etc/nginx/sites-enabled && \
    chown -R www-data:www-data /data/www /etc/nginx /tmp /var/lib/nginx /var/log/nginx /run/nginx/

USER www-data
EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
ENTRYPOINT ["entrypoint.sh"]
