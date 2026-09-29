#!/bin/sh
set -eu
if [ "${APP_RUN_MIGRATIONS:-false}" = "true" ] && [ "${DB_CONNECTION:-}" = "mysql" ]; then
    until php artisan db:show --no-ansi >/dev/null 2>&1; do
        echo "Waiting for database..."
        sleep 2
    done
    php artisan migrate --force --no-interaction
fi

if [ "${APP_RUN_MIGRATIONS:-false}" = "true" ]; then
    php artisan optimize --no-interaction
fi
exec "$@"
