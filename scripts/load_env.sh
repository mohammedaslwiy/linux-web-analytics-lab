#!/usr/bin/env bash
# Read simple KEY=value settings without executing .env as shell code.
load_env() {
  local file=$1 line key value
  [[ -f "$file" ]] || { printf 'Missing %s. Run bash scripts/init_env.sh.\n' "$file" >&2; return 1; }
  while IFS= read -r line || [[ -n "$line" ]]; do
    line=${line%$'\r'}
    [[ -z "$line" || "$line" == \#* ]] && continue
    [[ "$line" == *=* ]] || { printf 'Expected KEY=value in .env.\n' >&2; return 1; }
    key=${line%%=*}; value=${line#*=}
    case "$key" in
      DB_NAME|DB_USER|DB_PASSWORD|APP_SECRET|WEB_PORT|UMAMI_PORT|BIND_ADDRESS|VM_IP_OR_DOMAIN|UMAMI_WEBSITE_ID)
        printf -v "$key" '%s' "$value"
        export "$key"
        ;;
      *) printf 'Unknown .env setting: %s\n' "$key" >&2; return 1 ;;
    esac
  done < "$file"
  : "${WEB_PORT:=9090}" "${UMAMI_PORT:=9000}" "${BIND_ADDRESS:=127.0.0.1}" "${VM_IP_OR_DOMAIN:=localhost}" "${UMAMI_WEBSITE_ID:=}"
  [[ "${DB_NAME:-}" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ && "${DB_USER:-}" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]] || { printf 'Invalid database name or user.\n' >&2; return 1; }
  [[ "${DB_PASSWORD:-}" =~ ^[a-fA-F0-9]{48,}$ && "${APP_SECRET:-}" =~ ^[a-fA-F0-9]{64,}$ ]] || { printf 'Use generated hexadecimal secrets from init_env.sh.\n' >&2; return 1; }
  for value in "$WEB_PORT" "$UMAMI_PORT"; do
    [[ "$value" =~ ^[1-9][0-9]{3,4}$ ]] && (( 10#$value >= 1024 && 10#$value <= 65535 )) || { printf 'Ports must be between 1024 and 65535.\n' >&2; return 1; }
  done
  [[ "$WEB_PORT" != "$UMAMI_PORT" ]] || { printf 'The two ports must differ.\n' >&2; return 1; }
  [[ "$VM_IP_OR_DOMAIN" =~ ^[a-zA-Z0-9][a-zA-Z0-9.-]*$ && "$BIND_ADDRESS" =~ ^[0-9.]+$ ]] || { printf 'Invalid host or bind address.\n' >&2; return 1; }
  [[ -z "$UMAMI_WEBSITE_ID" || "$UMAMI_WEBSITE_ID" =~ ^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$ ]] || { printf 'The Umami website ID must be a UUID.\n' >&2; return 1; }
  export WEB_PORT UMAMI_PORT BIND_ADDRESS VM_IP_OR_DOMAIN UMAMI_WEBSITE_ID
}
