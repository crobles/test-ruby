#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# Ensure the database exists and is migrated
bundle exec rails db:create db:migrate

# Execute the container's main process
exec "$@"