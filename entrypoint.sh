#!/bin/bash
set -e

# 既存の server.pid があれば削除
rm -f /nokoripo/tmp/pids/server.pid

bundle exec rails db:migrate
exec "$@"

