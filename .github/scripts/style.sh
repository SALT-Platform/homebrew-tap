#!/usr/bin/env bash
# brew style needs the casks inside a tap: tap this checkout under its real name.
set -euo pipefail
# A tap cloned from a local path is a custom remote; style only reads the files.
export HOMEBREW_NO_REQUIRE_TAP_TRUST=1
brew tap salt-platform/tap "$PWD"
brew style --cask salt-platform/tap/salt-code
