#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
for script in "$ROOT"/scripts/*.sh "$ROOT"/deploy/*.sh "$ROOT"/upload.sh "$ROOT"/tests/*.sh; do
  bash -n "$script"
done
printf 'PASS: Bash syntax\n'

base=$(cd -- "${TMPDIR:-/tmp}" && pwd -P)
tmp=$(mktemp -d "$base/web-analytics-lab-tests.XXXXXX")
tmp=$(cd -- "$tmp" && pwd -P)
cleanup() {
  # Limit cleanup to the specific temporary test directory created above.
  [[ "$tmp" == "$base"/web-analytics-lab-tests.* && -d "$tmp" ]] && rm -rf -- "$tmp"
}
trap cleanup EXIT
mkdir -p "$tmp/deploy/html" "$tmp/scripts" "$tmp/fake-bin"
cp "$ROOT"/scripts/*.sh "$tmp/scripts/"
cp "$ROOT/deploy/.env.example" "$ROOT/deploy/index.template.html" "$tmp/deploy/"
template_before=$(cksum < "$tmp/deploy/index.template.html")
bash "$tmp/scripts/init_env.sh" >/dev/null
env_before=$(cksum < "$tmp/deploy/.env")
bash "$tmp/scripts/init_env.sh" >/dev/null
[[ "$env_before" == "$(cksum < "$tmp/deploy/.env")" ]]
printf 'PASS: secret initialization keeps existing configuration\n'

bash "$tmp/scripts/render_site.sh" >/dev/null
! grep -q '<script' "$tmp/deploy/html/index.html"
printf 'PASS: tracking is disabled without a website ID\n'
sed -i 's/^UMAMI_WEBSITE_ID=.*/UMAMI_WEBSITE_ID=12345678-1234-1234-1234-123456789abc/' "$tmp/deploy/.env"
bash "$tmp/scripts/render_site.sh" >/dev/null
grep -q 'http://localhost:9000/script.js' "$tmp/deploy/html/index.html"
grep -q '12345678-1234-1234-1234-123456789abc' "$tmp/deploy/html/index.html"
sed -i -e 's/^VM_IP_OR_DOMAIN=.*/VM_IP_OR_DOMAIN=example.test/' -e 's/^UMAMI_PORT=.*/UMAMI_PORT=9100/' "$tmp/deploy/.env"
bash "$tmp/scripts/render_site.sh" >/dev/null
grep -q 'http://example.test:9100/script.js' "$tmp/deploy/html/index.html"
[[ "$template_before" == "$(cksum < "$tmp/deploy/index.template.html")" ]]
printf 'PASS: repeated rendering applies host and port changes without editing the template\n'

cp "$tmp/deploy/.env" "$tmp/env.valid"
sed -i 's/^WEB_PORT=.*/WEB_PORT=9100/' "$tmp/deploy/.env"
if bash "$tmp/scripts/render_site.sh" >/dev/null 2>&1; then
  printf 'FAIL: equal ports accepted\n' >&2; exit 1
fi
cp "$tmp/env.valid" "$tmp/deploy/.env"
sed -i 's/^WEB_PORT=.*/WEB_PORT=70000/' "$tmp/deploy/.env"
if bash "$tmp/scripts/render_site.sh" >/dev/null 2>&1; then
  printf 'FAIL: out-of-range port accepted\n' >&2; exit 1
fi
cp "$tmp/env.valid" "$tmp/deploy/.env"
sed -i 's/^UMAMI_WEBSITE_ID=.*/UMAMI_WEBSITE_ID=invalid/' "$tmp/deploy/.env"
if bash "$tmp/scripts/render_site.sh" >/dev/null 2>&1; then
  printf 'FAIL: invalid website ID accepted\n' >&2; exit 1
fi
printf 'PASS: invalid configuration is rejected\n'

cp "$tmp/env.valid" "$tmp/deploy/.env"
printf 'VM_IP_OR_DOMAIN=$(touch "%s/injected")\n' "$tmp" >> "$tmp/deploy/.env"
if bash "$tmp/scripts/render_site.sh" >/dev/null 2>&1; then
  printf 'FAIL: unsafe host accepted\n' >&2; exit 1
fi
[[ ! -e "$tmp/injected" ]]
printf 'PASS: configuration values are not executed as shell commands\n'

cp "$tmp/env.valid" "$tmp/deploy/.env"
printf '#!/usr/bin/env bash\nexit "${CURL_RESULT:-0}"\n' > "$tmp/fake-bin/curl"
chmod +x "$tmp/fake-bin/curl"
PATH="$tmp/fake-bin:$PATH" bash "$tmp/scripts/check_services.sh" >/dev/null
if CURL_RESULT=1 PATH="$tmp/fake-bin:$PATH" bash "$tmp/scripts/check_services.sh" >/dev/null 2>&1; then
  printf 'FAIL: HTTP failure reported as success\n' >&2; exit 1
fi
printf 'PASS: service checks report success and failure\n'
printf 'All checks passed. These tests do not start containers.\n'
