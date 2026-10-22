#!/usr/bin/env bash
# Checks the app brew installed: version, architecture, signature, no quarantine,
# and that it launches (it shows its splash; no local stack runs on CI).
set -euo pipefail
app="/Applications/SALT Code (Beta).app"
exe="$app/Contents/MacOS/SALT Code (Beta)"
want="$(brew info --cask --json=v2 salt-platform/tap/salt-code | jq -r ".casks[0].version")"

test -d "$app"
got="$(plutil -extract CFBundleShortVersionString raw "$app/Contents/Info.plist")"
[ "$got" = "$want" ] || { echo "version $got, cask says $want" >&2; exit 1; }

case "$(uname -m)" in
  arm64) arch=arm64 ;;
  x86_64) arch=x86_64 ;;
  *) echo "unexpected machine $(uname -m)" >&2; exit 1 ;;
esac
lipo -archs "$exe" | grep -qw "$arch" || { echo "$exe is not $arch" >&2; exit 1; }

codesign --verify --deep --strict "$app"
if xattr -r -l "$app" | grep -q com.apple.quarantine; then
  echo "$app is still quarantined; Gatekeeper would block the first launch" >&2
  exit 1
fi
# Informational: an ad-hoc build is rejected here, a notarized one accepted.
spctl --assess --type execute -vv "$app" 2>&1 || true

open "$app"
for _ in $(seq 1 30); do
  pgrep -f "$exe" >/dev/null && break
  sleep 1
done
sleep 10
pgrep -f "$exe" >/dev/null || { echo "$app did not stay running" >&2; exit 1; }
screencapture -x launch.png || true
pkill -f "$exe" || true
echo "verified $app $got ($arch)"
