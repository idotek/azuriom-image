#!/bin/bash

set -e

passwd_gen() {
    password=$(tr -dc 'A-Za-z0-9!?%=' < /dev/urandom | head -c 10)
    php artisan user:create --admin --name="$ADMIN_USERNAME" --email="$ADMIN_EMAIL" --password="$password"
    echo "[########################################]"
    echo "[          Password: $password           ]"
    echo "[########################################]"
}

initialize() {
    export APP_KEY=$(cat .key)
    if [ -f .env ]; then
        rm .env
    fi
    for i in $(cat .env.temp|cut -d '=' -f1)
    do 
        j=$(cat .env.example |egrep "^$i" |cut -d '=' -f2)
        eval "export $i=\${$i:-$j}"
    done
    envsubst < .env.temp > .env
    chown www-data:www-data .env

}


install() {
    if [[ $TLS_ENABLED == "False" ]]; then
        sed -i "s/domain.tld/$WEB_DOMAIN/g" /etc/nginx/sites-available/azuriom_80
        ln -s /etc/nginx/sites-available/azuriom_80 /etc/nginx/sites-enabled/azuriom_80
    else
        sed -i "s/domain.tld/$WEB_DOMAIN/g" /etc/nginx/sites-available/azuriom_443
        sed -i "s/CHANGE_FULLCHAIN/$TLS_CERTIFICATE_FULLCHAIN_NAME/g" /etc/nginx/sites-available/azuriom_443
        sed -i "s/CHANGE_PRIVKEY/$TLS_CERTIFIATE_PRIVKEY_NAME/g" /etc/nginx/sites-available/azuriom_443
        ln -s /etc/nginx/sites-available/azuriom_443 /etc/nginx/sites-enabled/azuriom_443
    fi
    git clone https://github.com/Azuriom/Azuriom .
    cp /tmp/.env.temp ./ 
    initialize
    chmod -R 755 storage bootstrap/cache resources/themes plugins
    composer install
    php artisan key:generate
    cat .env |egrep "^APP_KEY" |cut -d "=" -f2 >> .key
    npm install && npm run prod
    php artisan migrate --seed --force
    php artisan storage:link
    chown -R www-data:www-data *
    passwd_gen
}




run() {
    printf "\n\nStarting PHP 8.3 daemon...\n\n"
    php-fpm --daemonize

    printf "Starting Nginx...\n\n"

    if [[ "$1" == -* ]]; then
        set -- nginx -g daemon off; "$@"
    fi

    exec "$@"
}

if [ ! -f index.php ]; then
    install
fi

initialize
run "$@"
