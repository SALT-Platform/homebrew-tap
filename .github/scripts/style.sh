#!/usr/bin/env bash
# brew style needs the casks inside a tap: tap this checkout under its real name.
set -euo pipefail
brew tap salt-platform/tap "$PWD"
brew style --cask salt-platform/tap/salt-code
