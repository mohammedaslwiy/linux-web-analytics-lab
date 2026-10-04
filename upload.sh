#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
[[ $# -eq 1 && "$1" == *@*:* && "$1" != -* && ! "$1" =~ [[:space:]] ]] || {
  printf 'Usage: bash upload.sh user@host:/absolute/path/to/web-analytics-lab\n' >&2; exit 1;
}
command -v rsync >/dev/null || { printf 'Install rsync first.\n' >&2; exit 1; }
# Transfer project files only. Create fresh .env secrets on the destination.
# No --delete: copying this lab does not remove remote files.
rsync -avz -e ssh --exclude='.git/' --include='.env.example' --exclude='.env' --exclude='.env.*' \
  --exclude='*.swp' --exclude='html/index.html' \
  "$ROOT/" "$1/"
