#!/bin/bash
set -e

# 既存の server.pid があれば削除
rm -f /nokoripo/tmp/pids/server.pid

# コンテナのメインプロセスを実行（DockerfileのCMDで指定されたもの）
exec "$@"
