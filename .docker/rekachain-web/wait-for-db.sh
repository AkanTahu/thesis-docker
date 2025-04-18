#!/bin/sh
until mysqladmin ping -h db --silent; do
    echo "⚡ Waiting for db to be ready..."
    sleep 2
done
echo "✅ Database is ready!"
exec "$@"