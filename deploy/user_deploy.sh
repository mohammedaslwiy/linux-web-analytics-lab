#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
source "$ROOT/scripts/load_env.sh"
load_env "$ROOT/deploy/.env"
[[ ${EUID:-0} -ne 0 ]] || { printf 'Run this lab as your regular Linux user.\n' >&2; exit 1; }
command -v podman >/dev/null || { printf 'Install Podman first.\n' >&2; exit 1; }
if command -v podman-compose >/dev/null; then
  COMPOSE=(podman-compose)
elif command -v docker-compose >/dev/null; then
  COMPOSE=(podman compose)
else
  printf 'Install a Compose provider, such as podman-compose.\n' >&2; exit 1
fi
bash "$ROOT/scripts/render_site.sh"
cd "$ROOT/deploy"
"${COMPOSE[@]}" -p web-analytics-lab -f compose.yaml config >/dev/null
"${COMPOSE[@]}" -p web-analytics-lab -f compose.yaml up -d
"${COMPOSE[@]}" -p web-analytics-lab -f compose.yaml ps
printf '\nContainers were started; first database setup may take a few minutes.\n'
printf 'Website: http://%s:%s\nUmami:   http://%s:%s\n' "$VM_IP_OR_DOMAIN" "$WEB_PORT" "$VM_IP_OR_DOMAIN" "$UMAMI_PORT"
printf 'Check HTTP responses with: bash scripts/check_services.sh\n'
