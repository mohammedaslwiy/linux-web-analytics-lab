#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
cd "$ROOT"
if [[ -e deploy/.env ]]; then
  printf 'deploy/.env already exists; keeping it unchanged.\n'
  exit 0
fi
command -v openssl >/dev/null || { printf 'Install openssl first.\n' >&2; exit 1; }
umask 077
DB_PASSWORD=$(openssl rand -hex 24)
APP_SECRET=$(openssl rand -hex 32)
sed -e "s/^DB_PASSWORD=.*/DB_PASSWORD=$DB_PASSWORD/" \
    -e "s/^APP_SECRET=.*/APP_SECRET=$APP_SECRET/" \
    deploy/.env.example > deploy/.env
printf 'Created deploy/.env with new local secrets. Keep this file out of Git.\n'
