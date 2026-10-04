#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
source "$ROOT/scripts/load_env.sh"
load_env "$ROOT/deploy/.env"
# Always render from the template so host/port changes work on later runs.
mkdir -p "$ROOT/deploy/html"
if [[ -n "$UMAMI_WEBSITE_ID" ]]; then
  sed -e "s/IP_DER_VM/$VM_IP_OR_DOMAIN/g" \
      -e "s/WEB_PORT_PLACEHOLDER/$WEB_PORT/g" \
      -e "s/UMAMI_PORT_PLACEHOLDER/$UMAMI_PORT/g" \
      -e "s/UMAMI_ID_PLACEHOLDER/$UMAMI_WEBSITE_ID/g" \
      "$ROOT/deploy/index.template.html" > "$ROOT/deploy/html/index.html"
else
  sed '/<script async defer/,/<\/script>/d' "$ROOT/deploy/index.template.html" \
    | sed -e "s/WEB_PORT_PLACEHOLDER/$WEB_PORT/g" -e "s/UMAMI_PORT_PLACEHOLDER/$UMAMI_PORT/g" \
          -e 's/Deine IP wurde (hoffentlich) gerade an Umami.*<\/p>/Tracking ist noch nicht eingerichtet.<\/p>/' \
    > "$ROOT/deploy/html/index.html"
fi
printf 'Rendered the website (tracking enabled only when an ID is configured).\n'
