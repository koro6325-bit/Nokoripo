#!/bin/bash
set -e

# サーバー起動前にマイグレーションを実行
bundle exec rails db:migrate

# 渡されたコマンド（CMD）を実行
exec "$@"
