#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
source "$ROOT/scripts/load_env.sh"
load_env "$ROOT/deploy/.env"
command -v curl >/dev/null || { printf 'Install curl first.\n' >&2; exit 1; }
failed=0
for endpoint in "http://$VM_IP_OR_DOMAIN:$WEB_PORT/" "http://$VM_IP_OR_DOMAIN:$UMAMI_PORT/"; do
  if curl --fail --silent --show-error --output /dev/null --connect-timeout 5 --max-time 15 "$endpoint"; then
    printf 'OK   %s\n' "$endpoint"
  else
    printf 'FAIL %s\n' "$endpoint" >&2
    failed=1
  fi
done
exit "$failed"
