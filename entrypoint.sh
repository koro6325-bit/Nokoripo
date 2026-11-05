#!/bin/bash
set -e

# 本番環境の初期化とマイグレーションを同時に安全に実行
bundle exec rails db:prepare

# サーバー（CMD）を起動
exec "$@"
