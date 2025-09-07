#!/bin/sh
set -e

# Crear logs y tmp si no existen
mkdir -p /app/log /app/tmp/pids
touch /app/log/production.log

# Asegurar que DB está lista antes de correr migraciones
echo "🔄 Waiting for database..."
until nc -z -v -w30 $DB_HOST $DB_PORT; do
  echo "⏳ Waiting for database at $DB_HOST:$DB_PORT..."
  sleep 2
done

echo "✅ Database is up!"

# Migraciones automáticas en producción
bundle exec rails db:migrate

# Arrancar el servidor Puma
exec bundle exec puma -C config/puma.rb
