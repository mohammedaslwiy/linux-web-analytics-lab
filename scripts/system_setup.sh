#!/usr/bin/env bash
set -euo pipefail
# Debian/Ubuntu lab prerequisites. Review, then run manually with sudo.
[[ ${EUID:-1} -eq 0 ]] || { printf 'Run with sudo on Debian/Ubuntu.\n' >&2; exit 1; }
command -v apt-get >/dev/null || { printf 'This installer supports Debian/Ubuntu only.\n' >&2; exit 1; }
apt-get update
apt-get install -y podman podman-compose slirp4netns dbus-user-session rsync openssl curl
printf 'Installed prerequisites. Run deployment as your regular user.\n'
