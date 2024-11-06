FROM php:8.3-fpm-bookworm

RUN apt update && \
    apt install -y zip \
    curl \
    mariadb-client \
    nginx \
    openssl \
    unzip \
    gnupg \
    git \
    gettext 

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions     
RUN install-php-extensions opcache pdo_mysql \
    bcmath \
    mbstring \
    pdo \
    tokenizer \
    xml \
    xmlwriter \
    curl \
    zip \
    sqlite3 \
    gd \
    mysqli \
    pgsql 

COPY docker/sites-available /etc/nginx/sites-available
ADD ./docker/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh && \
     chmod -R 770 /usr/local/bin/entrypoint.sh && \
     chown -R www-data:www-data /usr/local/bin/entrypoint.sh

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - 
RUN apt install nodejs -y
WORKDIR /data/www
COPY ./docker/.env.temp /tmp
RUN mkdir /etc/nginx/ssl
EXPOSE 80 443
RUN apt clean
CMD ["nginx", "-g", "daemon off;"]
ENTRYPOINT ["entrypoint.sh"]

