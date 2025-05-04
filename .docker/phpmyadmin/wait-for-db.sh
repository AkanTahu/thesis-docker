#!/bin/sh
echo "⌛ Waiting for DB to be ready..."
until nc -z db 3306; do
  sleep 2
done
echo "✅ DB is ready, launching phpMyAdmin"
exec "$@"